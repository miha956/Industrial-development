//
//  PostViewController.swift
//  Navigation
//
//  Created by Миша Вашкевич on 16.11.2023.
//

import UIKit

class PostViewController: UIViewController {
    
    
    
    var newTitle = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        title = newTitle
        view.backgroundColor = .red
        
        if #available(iOS 16.0, *) {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "info", image: nil, target: self, action: #selector(presentInfo))
        } else {
            // Fallback on earlier versions
        }
    }
    

    @objc func presentInfo() {
        
        let infoViewController = InfoViewController()
        infoViewController.modalPresentationStyle = .formSheet
        infoViewController.modalTransitionStyle = .coverVertical
        
        present(infoViewController, animated: true)
        
    }

}
