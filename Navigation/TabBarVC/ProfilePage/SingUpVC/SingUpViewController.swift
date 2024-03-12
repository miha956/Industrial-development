//
//  SingUpViewController.swift
//  Navigation
//
//  Created by Миша Вашкевич on 12.03.2024.
//

import UIKit

final class SingUpViewController: UIViewController {
    // MARK: - Properties
    
    weak var singUpCoordinator: SingUpCoordinatorProtocol?
    private var singUpViewModel: SingUpVMOutput
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
    private let yourNameLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Your Name"
        return view
    }()
    private let yourNameTextField: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.placeholder = "Some Person"
        return view
    }()
    private let emailAdressLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Email Adress"
        return view
    }()
    private let emailAdressTextField: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.placeholder = "somePerson@gmail.com"
        return view
    }()
    private let passwordLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Password"
        return view
    }()
    private let passwordTextField: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.placeholder = "******"
        view.isSecureTextEntry = true
        return view
    }()
    private let confirmPasswordLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Confirm Password"
        return view
    }()
    private let confirmPasswordTextField: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isSecureTextEntry = true
        view.placeholder = "******"
        return view
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
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addSubViews()
        setupConstraints()
    }
    init(singUpViewModel: SingUpVMOutput) {
        self.singUpViewModel = singUpViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("SingUpViewController deinit")
    }
    
    // MARK: Actions
    @objc private func didSingUpButtonTapped() {
        singUpViewModel.checkConfirmPassword(password: passwordTextField.text!, confirmPassword: confirmPasswordTextField.text!) { result in
            switch result {
            case true:
                print("passwords are equal")
                singUpViewModel.singUp(email: emailAdressTextField.text!, password: passwordTextField.text!) { [weak self] result in
                    guard let self = self else { return }
                    if result == true {
                        self.singUpCoordinator?.singUpAndLogin()
                    }
                }
            case false:
                print("passwords aren't equal")
            }
        }
    }
    // MARK: UI Setup
    private func setupView() {
        navigationController?.navigationBar.isHidden = false
        view.backgroundColor = .white
        title = "Sing Up"
    }
    private func addSubViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(yourNameLabel)
        contentView.addSubview(yourNameTextField)
        contentView.addSubview(emailAdressLabel)
        contentView.addSubview(emailAdressTextField)
        contentView.addSubview(passwordLabel)
        contentView.addSubview(passwordTextField)
        contentView.addSubview(confirmPasswordLabel)
        contentView.addSubview(confirmPasswordTextField)
        contentView.addSubview(singUpButton)
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
            
            yourNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            yourNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            yourNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            yourNameTextField.topAnchor.constraint(equalTo: yourNameLabel.bottomAnchor, constant: 15),
            yourNameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            yourNameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            emailAdressLabel.topAnchor.constraint(equalTo: yourNameTextField.bottomAnchor, constant: 15),
            emailAdressLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            emailAdressLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            emailAdressTextField.topAnchor.constraint(equalTo: emailAdressLabel.bottomAnchor, constant: 15),
            emailAdressTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            emailAdressTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            passwordLabel.topAnchor.constraint(equalTo: emailAdressTextField.bottomAnchor, constant: 15),
            passwordLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            passwordLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 15),
            passwordTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            passwordTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            confirmPasswordLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 15),
            confirmPasswordLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            confirmPasswordLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            confirmPasswordTextField.topAnchor.constraint(equalTo: confirmPasswordLabel.bottomAnchor, constant: 15),
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            singUpButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 5),
            singUpButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            singUpButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                                    
        ])
    }
}
