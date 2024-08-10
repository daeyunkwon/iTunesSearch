//
//  IconImageView.swift
//  iTunesSearch
//
//  Created by 권대윤 on 8/10/24.
//

import UIKit

import Kingfisher

final class SoftwareThumbImageView: UIImageView {
    
    init() {
        super.init(frame: .zero)
        
        self.contentMode = .scaleAspectFill
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
        self.backgroundColor = .lightGray
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImage(withURLString: String) {
        if let url = URL(string: withURLString) {
            self.kf.setImage(with: url) { [weak self] result in
                switch result {
                case .success(let value):
                    self?.image = value.image
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
