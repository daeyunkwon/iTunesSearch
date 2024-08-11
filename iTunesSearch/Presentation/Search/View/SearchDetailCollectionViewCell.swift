//
//  SearchDetailCollectionViewCell.swift
//  iTunesSearch
//
//  Created by 권대윤 on 8/11/24.
//

import UIKit

import SnapKit

final class SearchDetailCollectionViewCell: BaseCollectionViewCell {
    
    //MARK: - UI Components
    
    private let screenshotImageView = SoftwareThumbImageView()
    
    //MARK: - Configurations
    
    override func configureHierarchy() {
        contentView.addSubViews(screenshotImageView)
    }
    
    override func configureLayout() {
        screenshotImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func configureUI() {
        super.configureUI()
    }
    
    //MARK: - Methods
    
    func cellConfig(urlString: String) {
        self.screenshotImageView.setImage(withURLString: urlString)
    }
}
