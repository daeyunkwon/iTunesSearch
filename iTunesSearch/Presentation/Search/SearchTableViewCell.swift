//
//  SearchTableViewCell.swift
//  iTunesSearch
//
//  Created by 권대윤 on 8/10/24.
//

import UIKit

import Kingfisher
import SnapKit

final class SearchTableViewCell: BaseTableViewCell {
    
    //MARK: - UI Components
    
    private let iconImageView = SoftwareThumbImageView()
    
    private let softwareNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = Constant.Font.softwareName
        return label
    }()
    
    private lazy var downloadButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("받기", for: .normal)
        btn.setTitleColor(Constant.Color.Button.titleColor, for: .normal)
        btn.backgroundColor = Constant.Color.Button.backgroundColor
        btn.clipsToBounds = true
        btn.isUserInteractionEnabled = true
        btn.layer.cornerRadius = 17.5
        return btn
    }()
    
    private let starImageIcon: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "star.fill")
        return iv
    }()
    
    private let rateNumberLabel = SubInfoLabel()
    private let sellerNameLabel = SubInfoLabel()
    private let categoryLabel = SubInfoLabel()
    
    private let firstScreenshotImageView = SoftwareThumbImageView()
    private let secondScreenshotImageView = SoftwareThumbImageView()
    private let thirdScreenshotImageView = SoftwareThumbImageView()
    
    private lazy var stackViewForScreenshotImageViews: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [firstScreenshotImageView, secondScreenshotImageView, thirdScreenshotImageView])
        sv.axis = .horizontal
        sv.spacing = 5
        sv.distribution = .fillEqually
        return sv
    }()
    
    //MARK: - Configurations
    
    override func configureHierarchy() {
        contentView.addSubViews(
            iconImageView,
            downloadButton,
            softwareNameLabel,
            starImageIcon,
            rateNumberLabel,
            categoryLabel,
            sellerNameLabel,
            stackViewForScreenshotImageViews
        )
    }
    
    override func configureLayout() {
        iconImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(20)
            make.size.equalTo(65)
        }
        
        downloadButton.snp.makeConstraints { make in
            make.centerY.equalTo(iconImageView)
            make.trailing.equalToSuperview().inset(20)
            make.width.equalTo(80)
            make.height.equalTo(35)
        }
        
        softwareNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(iconImageView)
            make.leading.equalTo(iconImageView.snp.trailing).offset(5)
            make.trailing.equalTo(downloadButton.snp.leading).offset(-5)
        }
        
        starImageIcon.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(5)
            make.leading.equalToSuperview().inset(20)
            make.size.equalTo(25)
        }
        
        rateNumberLabel.snp.makeConstraints { make in
            make.centerY.equalTo(starImageIcon)
            make.leading.equalTo(starImageIcon.snp.trailing).offset(5)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.centerY.equalTo(starImageIcon)
            make.trailing.equalToSuperview().inset(20)
        }
        
        sellerNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(starImageIcon)
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
        }
        
        stackViewForScreenshotImageViews.snp.makeConstraints { make in
            make.top.equalTo(starImageIcon.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(10)
        }
    }
    
    override func configureUI() {
        super.configureUI()
        sellerNameLabel.textAlignment = .center
    }
    
    //MARK: - Methods
    
    func cellConfig(data: Software) {
        iconImageView.setImage(withURLString: data.artworkUrl100)
        iconImageView.layer.borderWidth = 0.5
        firstScreenshotImageView.setImage(withURLString: data.screenshotUrls[0])
        secondScreenshotImageView.setImage(withURLString: data.screenshotUrls[1])
        thirdScreenshotImageView.setImage(withURLString: data.screenshotUrls[2])
        softwareNameLabel.text = data.trackName
        categoryLabel.text = data.genres[0]
        rateNumberLabel.text = data.ratingString
        sellerNameLabel.text = data.sellerName
    }
}
