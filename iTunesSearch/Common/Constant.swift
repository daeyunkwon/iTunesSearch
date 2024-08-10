//
//  Constant.swift
//  iTunesSearch
//
//  Created by 권대윤 on 8/10/24.
//

import UIKit

enum Constant {
    
    enum Color {
        enum View {
            static let viewBackgroundColor: UIColor = .systemBackground
            static let navigationBarTintColor: UIColor = .systemBlue
        }
        
        enum Text {
            static let primaryColor: UIColor = .label
            
            static let subInformationColor: UIColor = .lightGray
        }
        
        enum Icon {
            static let primaryColor: UIColor = .systemBlue
        }
        
        enum Button {
            static let titleColor: UIColor = .white
            static let backgroundColor: UIColor = .systemBlue
        }
    }
    
    enum Font {
        static let softwareName: UIFont = .systemFont(ofSize: 20, weight: .heavy)
        
        static let softwareSubInformation: UIFont = .systemFont(ofSize: 11)
    }
}
