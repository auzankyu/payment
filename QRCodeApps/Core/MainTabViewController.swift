//
//  ViewController.swift
//  QRCodeApps
//
//  Created by Auzan Lazuardi on 30/01/24.
//

import UIKit

class MainTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTab()
        setupStyle()
    }

    private func setupTab() {
        let home = UINavigationController(rootViewController: HomeViewController())
        let history = UINavigationController(rootViewController: HistoryViewController())
        
        home.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        history.tabBarItem = UITabBarItem(title: "History", image: UIImage(systemName: "newspaper"), tag: 2)

        setViewControllers([home, history], animated: true)
    }
    
    private func setupStyle() {
        let tabAppearance = UITabBarAppearance()
        tabAppearance.configureWithDefaultBackground()
        
        UITabBar.appearance().standardAppearance = tabAppearance
        
        
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = tabAppearance
        }
    }

}

