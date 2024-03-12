//
//  LogInViewController.swift
//  Navigation
//
//  Created by Миша Вашкевич on 31.01.2024.
//

import UIKit

class LogInViewController: UIViewController {
    
    // MARK: - Properties
    weak var logInCoordinator: LogInCoordinatorProtocol?
    private var logInViewModel: LoginVMOutput
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
        logInButton.addTarget(self, action: #selector(didLogInButtonTapped), for: .touchUpInside)
        logInButton.isEnabled = false
        return logInButton
    }()
    private lazy var singUpButton: UIButton = {
        let singUpButton = UIButton(type: .system)
        singUpButton.backgroundColor = .clear
        singUpButton.translatesAutoresizingMaskIntoConstraints = false
        singUpButton.setTitle("Sing Up", for: .normal)
        singUpButton.setTitleColor(.systemBlue, for: .normal)
        singUpButton.titleLabel?.font = .systemFont(ofSize: 12)
        singUpButton.addTarget(self, action: #selector(didSingUpButtonTapped), for: .touchUpInside)
        return singUpButton
    }()
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.tintColor = .darkGray
        indicator.isHidden = true
        return indicator
    }()
        
    // MARK: - Lifecycle
        
    init(viewModel: LoginVMOutput) {
        
        self.logInViewModel = viewModel
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupKeyboardObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        removeKeyboardObservers()
    }
    
    deinit {
        print("LogInViewController deinit")
    }
    
    // MARK: Actions
        
    @objc private func didLogInButtonTapped() {
        logInViewModel.changeState(login: loginTextField.text ?? "", password: passwordTextField.text ?? "")
    }
    
    @objc private func didSingUpButtonTapped() {
        logInCoordinator?.singUp()
    }
    
        private func bindViewModel() {
            logInViewModel.currentState = { [weak self] state in
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
                        logInCoordinator?.logIn()
                    }
                case .error(let error):
                    print(error.localizedDescription)
                    DispatchQueue.main.async { [weak self] in
                        guard let self else { return }
                        activityIndicator.isHidden = true
                        activityIndicator.stopAnimating()
                        contentView.isHidden = false
                        showAlert(title: "Login or password is wrong", message: "Please, try again", target: self, handler: nil)
                    }
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
            contentView.addSubview(singUpButton)
            view.addSubview(activityIndicator)
        }
        private func setupConstraints() {
            let safeAreaLayoutGuide = view.safeAreaLayoutGuide
            
            NSLayoutConstraint.activate([
                scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
                scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
                
                contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
                contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                
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
                
                singUpButton.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: 5),
                singUpButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                singUpButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                
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

extension LogInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(
        _ textField: UITextField
    ) -> Bool {
        textField.resignFirstResponder()

        return true
    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        guard let mail = loginTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        // implenemt notofication
        
        if (mail.count >= 6) && (password.count >= 6) {
            logInButton.isEnabled = true
        } else {
            logInButton.isEnabled = false
        }
    }
}

// MARK: HideKeyboard

extension LogInViewController {
    
    @objc func willShowKeyboard(_ notification: NSNotification) {
    
        let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height
        guard let height = keyboardHeight else { print("get keyboardHeight error"); return }
        scrollView.contentInset.bottom = height + 50
    }

    @objc func willHideKeyboard(_ notification: NSNotification) {
        scrollView.contentInset.bottom = 0.0
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
