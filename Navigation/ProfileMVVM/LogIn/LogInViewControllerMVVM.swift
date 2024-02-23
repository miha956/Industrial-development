//
//  LogInViewController.swift
//  Navigation
//
//  Created by Миша Вашкевич on 31.01.2024.
//

import UIKit

class LogInViewControllerMVVM: UIViewController {
    
// MARK: - Properties
    
    private var viewModel: LoginVMOutput
    private var user: User? = nil
    
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
        loginTextField.text = "misha"
        loginTextField.delegate = self
        
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
        passwordTextField.delegate = self
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
        logInButton.addTarget(self, action: #selector(tapLogIn), for: .touchUpInside)
        return logInButton
    }()
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.tintColor = .darkGray
        indicator.isHidden = true
        return indicator
    }()
    private lazy var brutPasswordButton: UIButton = {
        let brutPasswordButton = UIButton(type: .system)
        brutPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        brutPasswordButton.setTitle("BturForse password", for: .normal)
        brutPasswordButton.addTarget(self, action: #selector(brutForce), for: .touchUpInside)
        return brutPasswordButton
    }()
    
    
// MARK: - Lifecycle
    
    init(viewModel: LoginVMOutput) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addSubviews()
        setupConstraints()
        bindViewModel()
    }
    
// MARK: Actions
        
    @objc private func tapLogIn() {
        viewModel.changeState(login: loginTextField.text ?? "", password: passwordTextField.text ?? "")
    }
    @objc private func brutForce() {
        let queue = DispatchQueue(label: "someQueueFast", qos: .userInteractive)
        queue.async { [weak self] in
            self?.viewModel.brutForse(passwordToUnlock: "123a")
        }
    }
    
    private func bindViewModel() {
        viewModel.currentState = { [weak self] state in
            guard let self else { return }
            
            switch state {
                case .initial:
                    print("initial")
                case .loading:
                    activityIndicator.isHidden = false
                    contentView.isHidden = true
                    activityIndicator.startAnimating()
                case .logined(let user):
                    DispatchQueue.main.async { [weak self] in
                        guard let self else { return }
                        self.user = user
                        activityIndicator.isHidden = true
                        activityIndicator.stopAnimating()
                        contentView.isHidden = false
                        let vc = ProfileViewController(currenyUser: user)
                        navigationController?.pushViewController(vc, animated: true)
                    }
                case .error:
                    print("error")
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    activityIndicator.isHidden = true
                    activityIndicator.stopAnimating()
                    contentView.isHidden = false
                    showAlert(title: "Login or password is wrong", message: "Please, try again", target: self, handler: nil)
                }
            }
        }
        viewModel.brutForseResult = { [weak self] state in
            guard let self else { return }
            switch state {
            case .initial: break
                //
            case .loading:
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    self.passwordTextField.leftViewMode = .always
                    self.passwordTextField.leftView = activityIndicator
                    self.activityIndicator.startAnimating()
                    self.passwordTextField.text = nil
                    self.passwordTextField.placeholder = ""
                }
            case .fetched(let password):
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    self.passwordTextField.isSecureTextEntry = false
                    self.passwordTextField.text = password
                    self.activityIndicator.stopAnimating()
                    passwordTextField.leftView = nil
                }
            case .error: break
                //
            }
        }
    }
    
// MARK: UI Setup
    
    private func setupView() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        
    }
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(logoImageView)
        logInStackview.addArrangedSubview(loginTextField)
        logInStackview.addArrangedSubview(passwordTextField)
        contentView.addSubview(logInStackview)
        contentView.addSubview(logInButton)
        contentView.addSubview(brutPasswordButton)
        view.addSubview(activityIndicator)
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
            
            brutPasswordButton.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: 16),
            brutPasswordButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            brutPasswordButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            brutPasswordButton.heightAnchor.constraint(equalToConstant: 20),
            brutPasswordButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            
        ])
        
        for view in logInStackview.arrangedSubviews {
            NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: 50)
        ])
            
        }
        
    }
}

// MARK: UITextFieldDelegate

extension LogInViewControllerMVVM: UITextFieldDelegate {
    
    func textFieldShouldReturn(
        _ textField: UITextField
    ) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
