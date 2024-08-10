//
//  ViewModelType.swift
//  iTunesSearch
//
//  Created by 권대윤 on 8/10/24.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
