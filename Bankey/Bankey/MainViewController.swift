//
//  MainViewController.swift
//  Bankey
//
//  Created by srinivas on 21/08/22.
//

import Foundation
import UIKit

class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        setupViews()
        setupTabBar()
    }
    
    func setupViews() {
        let summaryVC = AccountSummaryVC()
        let moneyVC = MoneyMoveVC()
        let moreVC = MoreVC()
        
        summaryVC.setTabBarImage(imageName: "list.dash.header.rectangle", title: "Summary")
        moneyVC.setTabBarImage(imageName: "arrow.left.arrow.right", title: "Move Money")
        moreVC.setTabBarImage(imageName: "ellipsis.circle", title: "More")
        
        let nc1 = UINavigationController(rootViewController: summaryVC)
        let nc2 = UINavigationController(rootViewController: moneyVC)
        let nc3 = UINavigationController(rootViewController: moreVC)
        
        nc1.navigationBar.barTintColor = appColor
        hideNavigationBarLine(nc1.navigationBar)
        
        let tabBarItems = [nc1, nc2, nc3]
        viewControllers = tabBarItems
    }
    
    private func hideNavigationBarLine(_ navigationBar: UINavigationBar) {
        let image = UIImage()
        navigationBar.shadowImage = image
        navigationBar.setBackgroundImage(image, for: .default)
        navigationBar.isTranslucent = false
    }
    
    func setupTabBar() {
        tabBar.tintColor = appColor
        tabBar.isTranslucent = false
    }
}


class  AccountSummaryVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
    }
}

class  MoneyMoveVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
    }
}

class  MoreVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
    }
}
