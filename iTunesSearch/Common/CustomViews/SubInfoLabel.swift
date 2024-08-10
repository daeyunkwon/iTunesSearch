//
//  SubInfoLabel.swift
//  iTunesSearch
//
//  Created by 권대윤 on 8/10/24.
//

import UIKit

final class SubInfoLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.font = Constant.Font.softwareSubInformation
        self.textColor = Constant.Color.Text.subInformationColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
