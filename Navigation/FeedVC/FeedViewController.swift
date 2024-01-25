//
//  FeedViewController.swift
//  Navigation
//
//  Created by Миша Вашкевич on 16.11.2023.
//

import UIKit

//struct Post {
//    
//    let title: String
//    
//}


class FeedViewController: UIViewController {
    
    let button = UIButton(type: .system)
    //let post = Post(title: "NEWNEWNEW")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Feed"
        view.backgroundColor = .darkGray
        button.setTitle("push", for: .normal)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
        
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    }
    
    @objc func pressButton() {
        
        guard let navigationController = navigationController else { return }
        let vc = PostViewController()
        //vc.newTitle = post.title
        
        navigationController.pushViewController(vc, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
