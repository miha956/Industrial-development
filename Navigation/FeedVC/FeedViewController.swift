//
//  FeedViewController.swift
//  Navigation
//
//  Created by Миша Вашкевич on 16.11.2023.
//

import UIKit

class FeedViewController: UIViewController {
    
    // MARK: - SubViews
    
    lazy var checkGuessButton: CustomButton = {
        let checkGuessButton = CustomButton(title: "Button",
                                            titleColor: .green) { [weak self] in
            print("taptap")
            
            if let text = self?.textField.text {
                FeedModel.shared.check(word: text)
            }
        }
        checkGuessButton.backgroundColor = .white
        return checkGuessButton
    }()
    let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 16)
        textField.autocapitalizationType = .none
        textField.placeholder = "word"
        textField.layer.cornerRadius = 10
        textField.layer.masksToBounds = true
        textField.backgroundColor = .white
        return textField
    }()
    let resultLabel: UILabel = {
        let resultLabel = UILabel()
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        resultLabel.backgroundColor = .white
        resultLabel.text = "result"
        return resultLabel
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Feed"
        setupView()
        addSubviews()
        setupConstraints()
        
        NotificationCenter.default.addObserver(self, selector: #selector(wordIsCorrect), name: NSNotification.Name("wordIsCorrect"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(wordIsWrong), name: NSNotification.Name("wordIsWrong"), object: nil)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Actions
    
    @objc func wordIsCorrect(_ notification: Notification) {
        print("yeeeah")
        self.resultLabel.text = "word is correct"
        self.resultLabel.textColor = .red
        self.resultLabel.backgroundColor = .green
        self.view.layoutSubviews()
    }
    @objc func wordIsWrong(_ notification: Notification) {
        print("noooo")
        self.resultLabel.text = "word is wrong"
        self.resultLabel.textColor = .white
        self.resultLabel.backgroundColor = .red
        self.view.layoutSubviews()
    }
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - Private

    private func setupView() {
        view.backgroundColor = .gray
        textField.delegate = self
        
    }
    
    private func addSubviews() {
        view.addSubview(checkGuessButton)
        view.addSubview(textField)
        view.addSubview(resultLabel)
    }
    
    private func setupConstraints() {
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            checkGuessButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            checkGuessButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            textField.bottomAnchor.constraint(equalTo: checkGuessButton.topAnchor, constant: -20),
            resultLabel.topAnchor.constraint(equalTo: checkGuessButton.bottomAnchor, constant: 20),
            resultLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            resultLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
    }
}

extension FeedViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(
        _ textField: UITextField
    ) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
