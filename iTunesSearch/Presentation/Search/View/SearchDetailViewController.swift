//
//  SearchDetailViewController.swift
//  iTunesSearch
//
//  Created by 권대윤 on 8/11/24.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit

final class SearchDetailViewController: BaseViewController {
    
    //MARK: - Properties
    
    private let disposeBag = DisposeBag()
    
    let viewModel = SearchDetailViewModel()
    
    //MARK: - UI Components
    
    private let scrollView: UIScrollView = UIScrollView()
    
    private let containerView = UIView()
    
    private let softwareIconImageView = SoftwareThumbImageView()
    
    private let softwareNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = Constant.Font.softwareName
        label.numberOfLines = 0
        return label
    }()
    
    private let sellerNameLabel: UILabel = {
        let label = SubInfoLabel()
        label.textAlignment = .left
        return label
    }()
    
    private let downloadButton: UIButton = DownloadButton()
    
    private let newsTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "새로운 소식"
        label.textAlignment = .left
        label.font = Constant.Font.softwareDescriptionTitle
        label.textColor = Constant.Color.Text.primaryColor
        return label
    }()
    
    private let releaseNoteTextView: UITextView = {
        let tv = UITextView()
        tv.font = Constant.Font.softwareDescription
        tv.textColor = Constant.Color.Text.primaryColor
        tv.isScrollEnabled = false
        tv.isEditable = false
        return tv
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 260, height: 400)
        layout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(SearchDetailCollectionViewCell.self, forCellWithReuseIdentifier: SearchDetailCollectionViewCell.identifier)
        cv.showsHorizontalScrollIndicator = false
        cv.isPagingEnabled = false
        cv.decelerationRate = UIScrollView.DecelerationRate.fast // 스크롤 시 빠르게 감속 되도록 설정
        return cv
    }()
    
    private let descriptionTextView: UITextView = {
        let tv = UITextView()
        tv.font = Constant.Font.softwareDescription
        tv.textColor = Constant.Color.Text.primaryColor
        tv.isScrollEnabled = false
        tv.isEditable = false
        return tv
    }()
    
    //MARK: - Life Cycle
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        downloadButton.layer.cornerRadius = downloadButton.frame.size.height / 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Configurations
    
    override func bind() {
        
        let input = SearchDetailViewModel.Input()
        let output = viewModel.transform(input: input)
        
        
        output.softwareIcon
            .bind(with: self) { owner, urlString in
                owner.softwareIconImageView.setImage(withURLString: urlString)
            }
            .disposed(by: disposeBag)
        
        output.softwareName
            .bind(to: softwareNameLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.sellerName
            .bind(to: sellerNameLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.releaseNote
            .bind(to: releaseNoteTextView.rx.text)
            .disposed(by: disposeBag)
        
        output.description
            .bind(to: descriptionTextView.rx.text)
            .disposed(by: disposeBag)
        
        output.screenshotUrls
            .bind(to: collectionView.rx.items(cellIdentifier: SearchDetailCollectionViewCell.identifier, cellType: SearchDetailCollectionViewCell.self)) { row, element, cell in
                cell.cellConfig(urlString: element)
            }
            .disposed(by: disposeBag)
        
        collectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
    }
    
    override func setupNavi() {
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func configureHierarchy() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(containerView)
        
        containerView.addSubViews(
            softwareIconImageView,
            softwareNameLabel,
            sellerNameLabel,
            downloadButton,
            newsTitleLabel,
            releaseNoteTextView,
            collectionView,
            descriptionTextView
        )
    }
    
    override func configureLayout() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        containerView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.verticalEdges.equalToSuperview().inset(16)
        }
        
        softwareIconImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.size.equalTo(105)
        }
        
        softwareNameLabel.snp.makeConstraints { make in
            make.top.equalTo(softwareIconImageView.snp.top).offset(10)
            make.leading.equalTo(softwareIconImageView.snp.trailing).offset(7)
            make.trailing.equalToSuperview()
        }
        
        sellerNameLabel.snp.makeConstraints { make in
            make.top.equalTo(softwareNameLabel.snp.bottom).offset(15)
            make.leading.trailing.equalTo(softwareNameLabel)
        }
        
        downloadButton.snp.makeConstraints { make in
            make.bottom.equalTo(softwareIconImageView)
            make.leading.equalTo(sellerNameLabel)
            make.width.equalTo(90)
            make.height.equalTo(35)
        }
        
        newsTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(softwareIconImageView.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview()
        }
        
        releaseNoteTextView.snp.makeConstraints { make in
            make.top.equalTo(newsTitleLabel.snp.bottom).offset(15)
            make.horizontalEdges.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(releaseNoteTextView.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(400)
        }
        
        descriptionTextView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(25)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    override func configureUI() {
        super.configureUI()
    }
}

//MARK: - UIScrollViewDelegate

extension SearchDetailViewController: UIScrollViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageWidth = 260.0 //itemCellSize
        let itemIndex = (targetContentOffset.pointee.x) / pageWidth
        targetContentOffset.pointee.x = round(itemIndex) * pageWidth
    }
}
