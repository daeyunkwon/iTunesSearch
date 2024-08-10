//
//  SearchViewModel.swift
//  iTunesSearch
//
//  Created by 권대윤 on 8/10/24.
//

import Foundation

import RxSwift
import RxCocoa

final class SearchViewModel: ViewModelType {
    
    //MARK: - Properties
    
    private let disposeBag = DisposeBag()
    
    private var softwareList: [Software] = []
    
    //MARK: - Inputs
    
    struct Input {
        let searchButtonTapped: ControlEvent<Void>
        let searchText: ControlProperty<String>
        let cellSelected: Observable<(ControlEvent<Software>.Element, ControlEvent<IndexPath>.Element)>
    }
    
    //MARK: - Outputs
    
    struct Output {
        let searchButtonTapped: ControlEvent<Void>
        let softwareList: Observable<[Software]>
        let networkError: PublishSubject<iTunesAPIError>
        let cellSelected: Observable<(ControlEvent<Software>.Element, ControlEvent<IndexPath>.Element)>
    }
    
    //MARK: - Methods

    func transform(input: Input) -> Output {
        
        let softwareList = PublishSubject<[Software]>()
        let networkError = PublishSubject<iTunesAPIError>()
        
        
        input.searchButtonTapped
            .withLatestFrom(input.searchText)
            .distinctUntilChanged()
            .bind(with: self) { owner, searchText in
                
                if !searchText.isEmpty {
                    let keyword = searchText.trimmingCharacters(in: .whitespaces).replacingOccurrences(of: " ", with: "+")
                    
                    NetworkManager.shared.fetchSoftwareData(searchKeyword: keyword)
                        .observe(on: MainScheduler.instance)
                        .subscribe(with: self) { owner, softwareResult in
                            owner.softwareList = softwareResult.results
                            softwareList.onNext(owner.softwareList)
                            
                        } onError: { owner, error in
                            let error = error as? iTunesAPIError
                            owner.softwareList = []
                            softwareList.onNext(owner.softwareList)
                            networkError.onNext(error ?? .invalidURL)
                        }
                        .disposed(by: owner.disposeBag)

                }
            }
            .disposed(by: disposeBag)
        
        return Output(searchButtonTapped: input.searchButtonTapped, softwareList: softwareList, networkError: networkError, cellSelected: input.cellSelected)
    }
}
