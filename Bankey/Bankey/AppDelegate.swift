//
//  AppDelegate.swift
//  Bankey
//
//  Created by srinivas on 15/08/22.
//

import UIKit

let appColor: UIColor = .systemTeal

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    let loginViewController = LoginViewController()
    let onboardingController = OnboardingContainerViewController()
    let mainViewController = MainViewController()
        
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        //login
          loginViewController.delegate = self
         onboardingController.delegate = self
        
//        window?.rootViewController = vc
        
        displayLogin()
        return true
    }
    
    private func displayLogin() {
        setRootViewController(loginViewController)
    }
    
    private func displayNextScreen() {
        if LocalState.hasOnboarded {
            prepMainView()
            setRootViewController(mainViewController)
        } else {
            setRootViewController(onboardingController)
        }
    }
    
    private func prepMainView() {
       mainViewController.setStatusBar()
       UINavigationBar.appearance().isTranslucent = false
       UINavigationBar.appearance().backgroundColor = appColor
    }
}

//Animation
extension AppDelegate {
    
    func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
        
        guard animated, let window = self.window else {
            window?.rootViewController = vc
            window?.makeKeyAndVisible()
            
            return
        }
        window.rootViewController = vc
        window.makeKeyAndVisible()
        
        UIView.transition(with: window, duration: 0.7, options: .transitionCrossDissolve, animations: nil, completion: nil)
        
    }
}

extension AppDelegate: LoginViewControllerDelegate {
    func didLogin() {
       displayNextScreen()
    }
}

extension AppDelegate: OnboardingContainerViewControllerDelegate {
    func didFinishOnboarding() {
        debugPrint("didFinishOnboarding...")
        LocalState.hasOnboarded = true
        prepMainView()
        setRootViewController(mainViewController)
    }
}

//logout
extension AppDelegate: DummyLogoutViewControllerDelegate {
    
    func didLogout() {
        debugPrint("didLogout...")
        setRootViewController(loginViewController)
    }
}

