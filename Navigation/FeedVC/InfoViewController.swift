//
//  InfoViewController.swift
//  Navigation
//
//  Created by Миша Вашкевич on 16.11.2023.
//

import UIKit

class InfoViewController: UIViewController {

    let button = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        
        button.setTitle("push", for: .normal)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func showAlert() {
        let alert = UIAlertController(title: "ahtung", message: "i do not know what is that, if i now, i will say you", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok", style: .default) { _ in
            print("some message for terminal")
        }
        let cancelActiom = UIAlertAction(title: "close", style: .destructive)
        
        alert.addAction(okAction)
        alert.addAction(cancelActiom)
        
        present(alert, animated: true)
    
    }

    
}
