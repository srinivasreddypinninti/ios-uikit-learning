//
//  DummyViewController.swift
//  Bankey
//
//  Created by srinivas on 20/08/22.
//

import Foundation
import UIKit


protocol DummyLogoutViewControllerDelegate: AnyObject {
    func didLogout()
}

class DummyLogoutViewController: UIViewController {
    

    let stackView = UIStackView()
    let label = UILabel()
    let button = UIButton(type: .system)
    
    weak var delegate: DummyLogoutViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
    func style() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .vertical
        stackView.spacing = 10
        
        label.text = "Welcome"
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        
        button.setTitle("Logout", for: [])
        button.configuration = .filled()
        button.addTarget(self, action: #selector(logoutTapped), for: .primaryActionTriggered)
    }
    
    func layout() {
        
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(button)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    }
}

//Action
extension DummyLogoutViewController {
    
    @objc func logoutTapped(_ sender: UIButton) {
        delegate?.didLogout()
    }
    
}
