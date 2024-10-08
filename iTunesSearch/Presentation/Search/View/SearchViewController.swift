//
//  ViewController.swift
//  iTunesSearch
//
//  Created by 권대윤 on 8/9/24.
//

import UIKit

import NVActivityIndicatorView
import RxSwift
import RxCocoa
import SnapKit

final class SearchViewController: BaseViewController {

    //MARK: - Properties
    
    private let disposeBag = DisposeBag()
    
    private let viewModel = SearchViewModel()
    
    //MARK: - UI Components
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.keyboardDismissMode = .onDrag
        tv.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        tv.rowHeight = 350
        return tv
    }()
    
    private let searchController: UISearchController = {
        let sc = UISearchController()
        sc.searchBar.placeholder = "게임, 앱, 스토리 등"
        sc.searchBar.autocorrectionType = .no
        sc.searchBar.autocapitalizationType = .none
        return sc
    }()
    
    private let indicatorView: NVActivityIndicatorView = {
        let indicatorView = NVActivityIndicatorView(frame: .init(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 80, height: 80)), type: .ballRotateChase)
        indicatorView.color = .systemBlue
        return indicatorView
    }()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Configurations
    
    override func bind() {
        
        let input = SearchViewModel.Input(
            searchButtonTapped: searchController.searchBar.rx.searchButtonClicked,
            searchText: searchController.searchBar.rx.text.orEmpty,
            cellSelected: Observable.zip(tableView.rx.modelSelected(Software.self), tableView.rx.itemSelected)
        )
        
        let output = viewModel.transform(input: input)
        
        output.searchButtonTapped
            .bind(with: self) { owner, _ in
                owner.indicatorView.startAnimating()
            }
            .disposed(by: disposeBag)
        
        let softwareList = output.softwareList
            .share()
        
        softwareList
            .bind(to: tableView.rx.items(cellIdentifier: SearchTableViewCell.identifier, cellType: SearchTableViewCell.self)) { row, element, cell in
                cell.cellConfig(data: element)
                self.indicatorView.stopAnimating()
            }
            .disposed(by: disposeBag)
        
        softwareList
            .bind(with: self) { owner, _ in
                owner.indicatorView.stopAnimating()
            }
            .disposed(by: disposeBag)
        
        output.networkError
            .subscribe(with: self) { owner, error in
                print(error.errorDescription)
                owner.showNetworkResponseFailAlert(errorType: error)
            }
            .disposed(by: disposeBag)
        
        output.cellSelected
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] software, indexPath in
                guard let self else { return }
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
                
                let vc = SearchDetailViewController()
                vc.viewModel.software = software
                self.pushViewController(vc)
            })
            .disposed(by: disposeBag)
    }
    
    override func setupNavi() {
        navigationItem.title = "검색"
        navigationController?.navigationBar.tintColor = Constant.Color.View.navigationBarTintColor
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
    }
    
    override func configureHierarchy() {
        view.addSubview(tableView)
        view.addSubview(indicatorView)
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }
        
        indicatorView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    override func configureUI() {
        super.configureUI()
    }
}

