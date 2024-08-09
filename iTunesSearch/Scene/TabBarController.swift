//
//  TabBarController.swift
//  iTunesSearch
//
//  Created by 권대윤 on 8/9/24.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        
        let dummy1 = UINavigationController(rootViewController: UIViewController())
        dummy1.tabBarItem = UITabBarItem(title: "투데이", image: UIImage(systemName: "book")?.applyingSymbolConfiguration(.init(font: UIFont.systemFont(ofSize: 16))), tag: 0)
        
        let dummy2 = UINavigationController(rootViewController: UIViewController())
        dummy2.tabBarItem = UITabBarItem(title: "게임", image: UIImage(systemName: "gamecontroller")?.applyingSymbolConfiguration(.init(font: UIFont.systemFont(ofSize: 16))), tag: 1)
        
        let dummy3 = UINavigationController(rootViewController: UIViewController())
        dummy3.tabBarItem = UITabBarItem(title: "앱", image: UIImage(systemName: "rectangle.stack.fill")?.applyingSymbolConfiguration(.init(font: UIFont.systemFont(ofSize: 16))), tag: 2)
        
        let dummy4 = UINavigationController(rootViewController: UIViewController())
        dummy4.tabBarItem = UITabBarItem(title: "아케이드", image: UIImage(systemName: "star")?.applyingSymbolConfiguration(.init(font: UIFont.systemFont(ofSize: 16))), tag: 3)
        
        let searchVC = UINavigationController(rootViewController: SearchViewController())
        searchVC.tabBarItem = UITabBarItem(title: "검색", image: UIImage(systemName: "magnifyingglass")?.applyingSymbolConfiguration(.init(font: UIFont.systemFont(ofSize: 16))), tag: 4)
        
        [dummy1, dummy2, dummy3, dummy4].forEach {
            $0.view.backgroundColor = .white
        }
        
        self.setViewControllers([dummy1, dummy2, dummy3, dummy4, searchVC], animated: false)
        
        self.selectedIndex = 4
    }
    
}
