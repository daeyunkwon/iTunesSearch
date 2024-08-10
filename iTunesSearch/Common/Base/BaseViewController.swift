//
//  BaseViewController.swift
//  iTunesSearch
//
//  Created by 권대윤 on 8/10/24.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavi()
        configureHierarchy()
        configureLayout()
        configureUI()
        bind()
    }
    
    func setupNavi() { }
    
    func configureHierarchy() { }
    
    func configureLayout() { }
    
    func configureUI() { view.backgroundColor = Constant.Color.View.viewBackgroundColor }
    
    func bind() { }
}
