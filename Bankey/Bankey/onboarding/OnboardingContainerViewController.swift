//
//  OnboardingContainerViewController.swift
//  Bankey
//
//  Created by srinivas on 16/08/22.
//

import Foundation
import UIKit

protocol OnboardingContainerViewControllerDelegate: AnyObject {
    func didFinishOnboarding()
}

class OnboardingContainerViewController: UIViewController {
    
    let pageViewController: UIPageViewController!
    var pages = [UIViewController]()
    var currentVC: UIViewController {
        didSet {
            guard let index = pages.firstIndex(of: currentVC) else { return }
            doneButton.isHidden =  index != 2 // done in last
            backButton.isHidden = index == 0 // back
            nextButton.isHidden = !doneButton.isHidden
        }
    }
    
    let closeButton = UIButton(type: .system)
    let nextButton = UIButton(type: .system)
    let doneButton = UIButton(type: .system)
    let backButton = UIButton(type: .system)
    
    weak var delegate: OnboardingContainerViewControllerDelegate?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        let page1 = OnboardingViewController(imageName: "delorean", labelText: "Everything you need to transition from hobbyist to professional iOS developer")
        let page2 = OnboardingViewController(imageName: "world", labelText: "Joining a company and starting work as an iOS engineer can initially feel overwhelming.")
        let page3 = OnboardingViewController(imageName: "thumbs", labelText: "Available on iOS and Android")
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        
        currentVC = pages.first!
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    required init?(coder: NSCoder) {
        fatalError("not impplemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        setup()
        style()
        layout()
    }
    
    private func setup() {
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController?.didMove(toParent: self)
        pageViewController?.dataSource = self
        pageViewController?.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: pageViewController.view.topAnchor),
            view.leadingAnchor.constraint(equalTo: pageViewController.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: pageViewController.view.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: pageViewController.view.bottomAnchor)
        ])
        
        pageViewController?.setViewControllers([pages.first!], direction: .forward, animated: true, completion: nil)
        currentVC = pages.first!
    }
    
    private func style() {
        // close
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setTitle("Close", for: [])
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .primaryActionTriggered)
        // next
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.setTitle("Next", for: [])
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .primaryActionTriggered)
        
        // done
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.setTitle("Done", for: [])
        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .primaryActionTriggered)
        
        // back
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setTitle("Back", for: [])
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .primaryActionTriggered)
        
        
    }
    
    private func layout() {
        
        view.addSubview(closeButton)
        view.addSubview(backButton)
        view.addSubview(nextButton)
        view.addSubview(doneButton)
        // close
        NSLayoutConstraint.activate([
            closeButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            closeButton.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2)
        ])
        
       //back
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: backButton.bottomAnchor, multiplier: 5)
        ])
        
        //next
         NSLayoutConstraint.activate([
           view.trailingAnchor.constraint(equalToSystemSpacingAfter: nextButton.trailingAnchor, multiplier: 2),
           view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: nextButton.bottomAnchor, multiplier: 5)
         ])
        
        //done
         NSLayoutConstraint.activate([
           view.trailingAnchor.constraint(equalToSystemSpacingAfter: doneButton.trailingAnchor, multiplier: 2),
           view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: doneButton.bottomAnchor, multiplier: 5)
         ])
    }
}

extension OnboardingContainerViewController: UIPageViewControllerDataSource {
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        pages.firstIndex(of: currentVC) ?? 0
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return viewControllerAfter(viewController)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return viewControllerBefore(viewController)
    }
    
    func viewControllerAfter(_ viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index + 1 < pages.count else { return nil }
        let vc = pages[index + 1]
        currentVC = vc
        return vc
    }
    
    func viewControllerBefore(_ viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index - 1 >= 0 else { return nil }
        let vc = pages[index - 1]
        currentVC = vc
        return vc
    }
    
}

// MARK: - Actions
extension OnboardingContainerViewController {
    //close
    @objc func closeButtonTapped(_ sender: UIButton) {
        delegate?.didFinishOnboarding()
    }
    
    //next
    @objc func nextButtonTapped(_ sender: UIButton) {
        let vc = viewControllerAfter(currentVC)!
        currentVC = vc
        pageViewController?.setViewControllers([vc], direction: .forward, animated: true, completion: nil)
        
    }
    
    //back
    @objc func backButtonTapped(_ sender: UIButton) {
        let vc = viewControllerBefore(currentVC)!
        currentVC = vc
        pageViewController?.setViewControllers([vc], direction: .reverse, animated: true, completion: nil)
    }
    
    //done
    @objc func doneButtonTapped(_ sender: UIButton) {
        delegate?.didFinishOnboarding()
    }
    
}
