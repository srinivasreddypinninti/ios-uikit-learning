//
//  ViewController.swift
//  Bankey
//
//  Created by srinivas on 15/08/22.
//

import UIKit

protocol LoginViewControllerDelegate: AnyObject {
    func didLogin()
}

class LoginViewController: UIViewController {

    let stackView = UIStackView()
    let titleLabel = UILabel()
    let subTitleLabel = UILabel()
    let loginView = LoginView()
    let signInButton = UIButton(type: .system)
    let errorLabel = UILabel()
    
    var userName: String? {
        return loginView.userNameTextField.text
    }
    
    var password: String? {
        return loginView.passwordTextField.text
    }
    
    
    weak var delegate: LoginViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        signInButton.configuration?.showsActivityIndicator = false
    }
}

extension LoginViewController {
    
    func style() {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        // stackView
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        
        // signInButton
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.configuration = .filled()
        signInButton.configuration?.imagePadding = 8
        signInButton.setTitle("Sign In", for: [])
        signInButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
        
        // errorLabel
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.text = "Error failure"
        errorLabel.textColor = .systemRed
        errorLabel.isHidden = true
        errorLabel.textAlignment = .center
        errorLabel.numberOfLines = 0
        
        //titleLabel
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Bankey"
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 30)
        
        // subTitleLabel
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.text = "Your premium source for all things banking"
        subTitleLabel.textColor = .secondaryLabel
        subTitleLabel.textAlignment = .center
        subTitleLabel.font = UIFont.systemFont(ofSize: 20)
        subTitleLabel.numberOfLines = 0
    }
    
    func layout() {
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subTitleLabel)
        stackView.addArrangedSubview(loginView)
        stackView.addArrangedSubview(signInButton)
        stackView.addArrangedSubview(errorLabel)
        view.addSubview(stackView)
        
        
        // stackView
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1)
        ])
        
        //titleLabel
//        NSLayoutConstraint.activate([
//            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            titleLabel.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 4)
//
//        ])
//
//        // loginView
//        NSLayoutConstraint.activate([
//            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
//            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1)
//        ])
//
//        // signInView
//        NSLayoutConstraint.activate([
//            signInButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2),
//            signInButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
//            signInButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
//        ])
//
//        // errorLabel
//        NSLayoutConstraint.activate([
//            errorLabel.topAnchor.constraint(equalToSystemSpacingBelow: signInButton.bottomAnchor, multiplier: 2),
//            errorLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
//            errorLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
//        ])
        
    }
}

// MARK: - Actions
extension LoginViewController {
    @objc func signInTapped(_ sender: UIButton) {
        errorLabel.isHidden = true
        login()
    }
    
    private func login() {
        guard let userName = userName, let password = password else {
            assertionFailure("Username / Password should not be nil")
            return
        }
        
//        if userName.isEmpty || password.isEmpty {
//            configureView(withMessage: "Username/Password can't be blank")
//            return
//        }
        
        if userName == "" && password == "" {
            signInButton.configuration?.showsActivityIndicator = true
            delegate?.didLogin()
        } else {
            configureView(withMessage: "Username/Password incorrect")
        }
    }
    
    private func configureView(withMessage message: String) {
        errorLabel.isHidden = false
        errorLabel.text = message
    }
}
