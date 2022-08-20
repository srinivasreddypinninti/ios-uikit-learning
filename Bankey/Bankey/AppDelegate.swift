//
//  AppDelegate.swift
//  Bankey
//
//  Created by srinivas on 15/08/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    let loginViewController = LoginViewController()
    let onboardingController = OnboardingContainerViewController()
    let dummyVc = DummyLogoutViewController()
        
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        //login
          loginViewController.delegate = self
         onboardingController.delegate = self
        dummyVc.delegate = self
        
         window?.rootViewController = loginViewController
                
        return true
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
        if LocalState.hasOnboarded {
            setRootViewController(dummyVc)
        } else {
            setRootViewController(onboardingController)
        }
    }
}

extension AppDelegate: OnboardingContainerViewControllerDelegate {
    func didFinishOnboarding() {
        debugPrint("didFinishOnboarding...")
        LocalState.hasOnboarded = true
        setRootViewController(dummyVc)
    }
}

//logout
extension AppDelegate: DummyLogoutViewControllerDelegate {
    
    func didLogout() {
        debugPrint("didLogout...")
        setRootViewController(loginViewController)
    }
}

