//
//  FavoritPostsViewController.swift
//  Navigation
//
//  Created by Миша Вашкевич on 27.03.2024.
//

import UIKit
import StorageService

class FavoritPostsViewController: UIViewController {
    
    // MARK: Properties
    private let coreDataManager: CoreDataManagerProtocol
    private lazy var posts: [Post] = {
        self.coreDataManager.posts
    }()
    
    // MARK: Subviews
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    init(coreDataManager: CoreDataManagerProtocol) {
        self.coreDataManager = coreDataManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private
    
    private func setupView() {
        view.addSubview(tableView)
        tableView.backgroundColor = .white
        tableView.register(
            PostTableViewCell.self,
            forCellReuseIdentifier: "PostTableViewCell_ReuseID"
                )
        
        tableView.delegate = self
        tableView.dataSource = self
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
    }
}

extension FavoritPostsViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let postCell = tableView.dequeueReusableCell(
                withIdentifier: "PostTableViewCell_ReuseID",
                for: indexPath) as? PostTableViewCell else {
                fatalError("could not dequeueReusableCell")
        }
        let post = PostStruct(author: posts[indexPath.row].author!,
                              description: posts[indexPath.row].postText!,
                              image: UIImage(data: posts[indexPath.row].image!),
                              likes: Int(posts[indexPath.row].likes),
                              views: Int(posts[indexPath.row].views))
        postCell.update(post)
        return postCell
    }
    
    
}

