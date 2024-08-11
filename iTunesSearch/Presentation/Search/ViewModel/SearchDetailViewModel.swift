//
//  SearchDetailViewModel.swift
//  iTunesSearch
//
//  Created by 권대윤 on 8/11/24.
//

import Foundation

import RxSwift
import RxCocoa

final class SearchDetailViewModel: ViewModelType {
    
    //MARK: - Properties
    
    var software: Software?
    
    private let disposeBag = DisposeBag()
    
    private let screenshotUrls: [String] = []
    
    //MARK: - Inputs
    
    struct Input {
        
    }
    
    //MARK: - Outputs
    
    struct Output {
        let softwareIcon: AsyncSubject<String>
        let softwareName: AsyncSubject<String?>
        let sellerName: AsyncSubject<String?>
        let releaseNote: AsyncSubject<String?>
        let description: AsyncSubject<String?>
        let screenshotUrls: AsyncSubject<[String]>
    }
    
    //MARK: - Methods
    
    func transform(input: Input) -> Output {
        
        let software = BehaviorRelay(value: self.software)
        let softwareIcon = AsyncSubject<String>()
        let softwareName = AsyncSubject<String?>()
        let sellerName = AsyncSubject<String?>()
        let releaseNote = AsyncSubject<String?>()
        let description = AsyncSubject<String?>()
        let screenshotUrls = AsyncSubject<[String]>()
        
        software
            .compactMap { $0 }
            .map { $0.artworkUrl100 }
            .bind(onNext: { value in
                softwareIcon.onNext(value)
                softwareIcon.onCompleted()
            })
            .disposed(by: disposeBag)
        
        software
            .compactMap { $0 }
            .map { $0.trackName }
            .bind(onNext: { value in
                softwareName.onNext(value)
                softwareName.onCompleted()
            })
            .disposed(by: disposeBag)
        
        software
            .compactMap { $0 }
            .map { $0.sellerName }
            .bind(onNext: { value in
                sellerName.onNext(value)
                sellerName.onCompleted()
            })
            .disposed(by: disposeBag)
        
        software
            .compactMap { $0 }
            .map { $0.releaseNotes }
            .bind(onNext: { value in
                releaseNote.onNext(value)
                releaseNote.onCompleted()
            })
            .disposed(by: disposeBag)
        
        software
            .compactMap { $0 }
            .map { $0.description }
            .bind(onNext: { value in
                description.onNext(value)
                description.onCompleted()
            })
            .disposed(by: disposeBag)
        
        software
            .compactMap { $0 }
            .map { $0.screenshotUrls }
            .bind { value in
                screenshotUrls.onNext(value)
                screenshotUrls.onCompleted()
            }
            .disposed(by: disposeBag)
        
        
        return Output(
            softwareIcon: softwareIcon,
            softwareName: softwareName,
            sellerName: sellerName,
            releaseNote: releaseNote,
            description: description,
            screenshotUrls: screenshotUrls
        )
    }
}
