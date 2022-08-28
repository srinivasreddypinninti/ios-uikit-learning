//
//  MainViewController.swift
//  Bankey
//
//  Created by srinivas on 25/08/22.
//

import UIKit

class MainViewController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        
        let summaryVC = AccountSummaryViewController()
        let moneyVC = MoneyVC()
        let moreVC = MoreVC()
        
        summaryVC.tabarImage(systemImage: "list.dash.header.rectangle", tabName: "Summary")
        moneyVC.tabarImage(systemImage: "arrow.left.arrow.right", tabName: "Money")
        moreVC.tabarImage(systemImage: "ellipsis.circle", tabName: "More")
        
//        summaryVC.tabBarItem = UITabBarItem(tabBarSystemItem: "", tag: 0)
//        moneyVC.tabBarItem = UITabBarItem(tabBarSystemItem: "", tag: 1)
//        moreVC.tabBarItem = UITabBarItem(tabBarSystemItem: "", tag: 2)
        
        let summaryNC = UINavigationController(rootViewController: summaryVC)
        let moneyNC = UINavigationController(rootViewController: moneyVC)
        let moreNC = UINavigationController(rootViewController: moreVC)
        
        let tabs = [summaryNC, moneyNC, moreNC]
        
//        let tabBarController = UITabBarController()
//        tabBarController.setViewControllers(tabs, animated: true)
        
        summaryNC.navigationBar.barTintColor = appColor
        hideNavBarLine(summaryNC.navigationBar)
        
        viewControllers = tabs
        
        tabBar.tintColor = appColor
        tabBar.isTranslucent = false
        
    }
    
    
    private func hideNavBarLine(_ nav: UINavigationBar) {
        let dummyImage = UIImage()
        nav.shadowImage = dummyImage
        nav.setBackgroundImage(dummyImage, for: .default)
        nav.isTranslucent = false
    }
    
    
}


//class SummaryVC: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .systemRed
//    }
//}

class MoneyVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
    }
}

class MoreVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
    }
}

extension UIViewController {
    
    func tabarImage(systemImage: String, tabName: String) {
        let config = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: systemImage, withConfiguration: config)
        tabBarItem = UITabBarItem(title: tabName, image: image, tag: 0)
        
    }
    
}
