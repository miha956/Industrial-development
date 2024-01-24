//
//  LogInViewController.swift
//  Navigation
//
//  Created by Миша Вашкевич on 04.12.2023.
//

import UIKit

class LogInViewController: UIViewController {
    
    // MARK: - Properties
    
    var loginDelegate: LoginViewControllerDelegate?
    
    // MARK: - SubViews
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = .clear
        scrollView.contentInset.bottom = 0
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .clear
        return contentView
    }()
    private lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "logo")
        return logoImageView
    }()
    private lazy var loginTextField: UITextField = {
        let loginTextField = UITextField()
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        loginTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        loginTextField.textColor = .black
        loginTextField.font = .systemFont(ofSize: 16)
        loginTextField.tintColor = .vk
        loginTextField.autocapitalizationType = .none
        loginTextField.placeholder = "Email or phone"
        loginTextField.layer.borderWidth = 0.5
        loginTextField.layer.cornerRadius = 10
        loginTextField.layer.masksToBounds = true
        loginTextField.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        loginTextField.layer.borderColor = UIColor.lightGray.cgColor
        
        return loginTextField
    }()
    private lazy var passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        passwordTextField.textColor = .black
        passwordTextField.font = .systemFont(ofSize: 16)
        passwordTextField.tintColor = .vk
        passwordTextField.autocapitalizationType = .none
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.layer.borderWidth = 0.5
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.layer.masksToBounds = true
        passwordTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
        return passwordTextField
    }()
    private lazy var logInStackview: UIStackView = {
        let logInStackview = UIStackView()
        logInStackview.translatesAutoresizingMaskIntoConstraints = false
        logInStackview.axis = .vertical
        logInStackview.clipsToBounds = true
        logInStackview.layer.cornerRadius = 10
        logInStackview.backgroundColor = .systemGray6
        logInStackview.alignment = .fill

        return logInStackview
    }()
    private lazy var logInButton: UIButton = {
        let logInButton = UIButton()
        logInButton.tintColor = .white
        logInButton.layer.cornerRadius = 10
        logInButton.clipsToBounds = true
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        logInButton.setTitle("Log In", for: .normal)
        logInButton.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        logInButton.addTarget(nil, action: #selector(logIntapped), for: .touchUpInside)

        return logInButton
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addSubviews()
        setupConstraints()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupKeyboardObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        removeKeyboardObservers()
    }
    
    // MARK: - Actions
    
    @objc func willShowKeyboard(_ notification: NSNotification) {
        
            let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height
            guard let height = keyboardHeight else { print("get keyboardHeight error"); return }
            scrollView.contentInset.bottom = height + 50
            print("height \(height)")
            print(scrollView.contentInset.bottom)
        
    }
    
    @objc func willHideKeyboard(_ notification: NSNotification) {
        scrollView.contentInset.bottom = 0.0
    }
    
    @objc func logIntapped() {
        
        guard let login = loginTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        guard let loginDelegate = self.loginDelegate as? LoginInspector else {return}
        
        if loginDelegate.check(login: login, password: password) {
            if let user = loginDelegate.checkUser(login: login) {
                let vc = ProfileViewController(currenyUser: user)
                navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            showAlert(title: "Login or password is wrong", message: "Please, try again", target: self, handler: nil)
        }
        
//        #if DEBUG
//        let user = TestUserService(user: User.make())
//        #else
//        let user = CurrentUserService(user: User.make())
//        #endif
//        if let success = user.checkUser(login: login) {
//            let vc = ProfileViewController(currenyUser: success)
//            navigationController?.pushViewController(vc, animated: true)
//        } else {
//            print("wrong user")
//        }
    }


    // MARK: - private
    
    private func setupView() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        loginTextField.delegate = self
        passwordTextField.delegate = self
        
    }
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(logoImageView)
        logInStackview.addArrangedSubview(loginTextField)
        logInStackview.addArrangedSubview(passwordTextField)
        contentView.addSubview(logInStackview)
        contentView.addSubview(logInButton)
        
        setupKeyboardObservers()
    }
    private func setupConstraints() {
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            logoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            
            logInStackview.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 120),
            logInStackview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            logInStackview.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            logInStackview.heightAnchor.constraint(equalToConstant: 100),
            
            logInButton.topAnchor.constraint(equalTo: logInStackview.bottomAnchor, constant: 16),
            logInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            logInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            logInButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
            
        ])
        
        for view in logInStackview.arrangedSubviews {
            NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: 50)
        ])
            
        }
        
    }
    private func setupKeyboardObservers() {
            let notificationCenter = NotificationCenter.default
            
            notificationCenter.addObserver(
                self,
                selector: #selector(self.willShowKeyboard(_:)),
                name: UIResponder.keyboardDidShowNotification,
                object: nil
            )
            
            notificationCenter.addObserver(
                self,
                selector: #selector(self.willHideKeyboard(_:)),
                name: UIResponder.keyboardWillHideNotification,
                object: nil
            )
        }
        
        private func removeKeyboardObservers() {
            let notificationCenter = NotificationCenter.default
            notificationCenter.removeObserver(self)
        }
}

extension LogInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(
        _ textField: UITextField
    ) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
