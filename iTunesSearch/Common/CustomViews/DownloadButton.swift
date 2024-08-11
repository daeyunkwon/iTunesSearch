//
//  DownloadButton.swift
//  iTunesSearch
//
//  Created by 권대윤 on 8/11/24.
//

import UIKit

final class DownloadButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init() {
        self.init(type: .system)
        
        self.setTitle("받기", for: .normal)
        self.setTitleColor(Constant.Color.Button.titleColor, for: .normal)
        self.backgroundColor = Constant.Color.Button.backgroundColor
        self.clipsToBounds = true
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
