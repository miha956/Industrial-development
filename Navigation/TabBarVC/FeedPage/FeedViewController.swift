//
//  FeedViewController.swift
//  Navigation
//
//  Created by Миша Вашкевич on 16.11.2023.
//

import UIKit

class FeedViewController: UIViewController {
    
    weak var feedViewCoordinator: FeedPageCoordinatorProtocol?
    
    // MARK: - SubViews
    
    let resultLabel: UILabel = {
        let resultLabel = UILabel()
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        resultLabel.backgroundColor = .white
        resultLabel.text = "text"
        return resultLabel
    }()
    let planetLabel: UILabel = {
        let planetLabel = UILabel()
        planetLabel.translatesAutoresizingMaskIntoConstraints = false
        planetLabel.backgroundColor = .white
        planetLabel.text = "text"
        return planetLabel
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Feed"
        setupView()
        addSubviews()
        setupConstraints()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        
    }
    
    // MARK: - Actions
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - Private

    private func setupView() {
        view.backgroundColor = .gray
        
    }
    
    private func addSubviews() {
        view.addSubview(resultLabel)
        view.addSubview(planetLabel)
    }
    
    private func setupConstraints() {
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([

            resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            resultLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            resultLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            planetLabel.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 20),
            planetLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            planetLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
        ])
    }
}
