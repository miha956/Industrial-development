//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Миша Вашкевич on 28.11.2023.
//

import UIKit
import StorageService

class ProfileViewController: UIViewController {
    
    // MARK: - Data
    
    fileprivate let data = Post.make()
    fileprivate let userData = User.make()
    
    // MARK: - Subviews
    
    static var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    private enum CellReuseID: String {
            case postCell = "PostTableViewCell_ReuseID"
            case photosCell = "PhotosTableViewCell_ReuseID"
        }
    private enum HeaderFooterReuseID: String {
            case base = "ProfileTableHederView_ReuseID"
        }
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addSubviews()
        tuneTableView()
        setupConstraints()
        
        #if DEBUG
        Self.tableView.backgroundColor = .red
        #else
        // nothing to do
        #endif
        
    }
    
    // MARK: - Actions
     
    // MARK: - private
    
    private func setupView() {
         view.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
     }
    
    private func addSubviews() {
        view.addSubview(Self.tableView)
    }
    
    private func setupConstraints() {
        
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            Self.tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            Self.tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            Self.tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            Self.tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }
    
}

    // MARK: - tableView

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func tuneTableView() {
        
        Self.tableView.allowsSelection = true
        
        Self.tableView.rowHeight = UITableView.automaticDimension
        Self.tableView.register(
            PostTableViewCell.self,
            forCellReuseIdentifier: CellReuseID.postCell.rawValue
                )
        Self.tableView.register(
            PhotosTableViewCell.self,
            forCellReuseIdentifier: CellReuseID.photosCell.rawValue
                )
        Self.tableView.register(
            ProfileHeaderView.self,
            forHeaderFooterViewReuseIdentifier: HeaderFooterReuseID.base.rawValue
        )
        
        Self.tableView.dataSource = self
        Self.tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: HeaderFooterReuseID.base.rawValue) as? 
            ProfileHeaderView else {
            fatalError("could not dequeueReusableCell")
            
        }
        if section == 0 {
            return headerView
        } else {
            return nil
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return data.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let postCell = tableView.dequeueReusableCell(
                withIdentifier: CellReuseID.postCell.rawValue,
                for: indexPath) as? PostTableViewCell else {
                fatalError("could not dequeueReusableCell")
        }
        guard let photosCell = tableView.dequeueReusableCell(
                withIdentifier: CellReuseID.photosCell.rawValue,
                for: indexPath) as? PhotosTableViewCell else {
                fatalError("could not dequeueReusableCell")
        }
        postCell.update(data[indexPath.row])
        photosCell.updateData(photos: userData.photos)
        
        switch indexPath.section {
        case 0:
            return photosCell
        case 1:
            return postCell
        default:
            return UITableViewCell(style: .default, reuseIdentifier: "base")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let vc = PhotosViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
