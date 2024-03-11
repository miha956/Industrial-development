//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Миша Вашкевич on 07.12.2023.
//

import UIKit
import StorageService

class PostTableViewCell: UITableViewCell {
    
    // MARK: - Subviews
    
    private let authorLabel: UILabel = {
        let authorLabel = UILabel()
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.font = .systemFont(ofSize: 20, weight: .bold)
        authorLabel.textColor = .black
        authorLabel.numberOfLines = 2
        authorLabel.sizeToFit()
        return authorLabel
    }()
    private let postImage: UIImageView = {
        let postImage = UIImageView()
        postImage.translatesAutoresizingMaskIntoConstraints = false
        postImage.contentMode = .scaleAspectFit
        postImage.backgroundColor = .black
        return postImage
    }()
    private let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = .systemFont(ofSize: 14)
        descriptionLabel.textColor = .systemGray
        descriptionLabel.numberOfLines = 0
        return descriptionLabel
    }()
    private let likesLabel: UILabel = {
        let likesLabel = UILabel()
        likesLabel.translatesAutoresizingMaskIntoConstraints = false
        likesLabel.text = "Likes:"
        likesLabel.font = .systemFont(ofSize: 16)
        likesLabel.textColor = .black
        return likesLabel
    }()
    private let likesCountLabel: UILabel = {
        let likesCountLabel = UILabel()
        likesCountLabel.translatesAutoresizingMaskIntoConstraints = false
        likesCountLabel.text = "0"
        likesCountLabel.font = .systemFont(ofSize: 16)
        likesCountLabel.textColor = .black
        return likesCountLabel
    }()
    private let likesStackView: UIStackView = {
        let likesStackView = UIStackView()
        likesStackView.translatesAutoresizingMaskIntoConstraints = false
        likesStackView.axis = .horizontal
        likesStackView.spacing = 4
        likesStackView.alignment = .leading
        return likesStackView
    }()
    private let viewsLabel: UILabel = {
        let viewsLabel = UILabel()
        viewsLabel.translatesAutoresizingMaskIntoConstraints = false
        viewsLabel.text = "Views:"
        viewsLabel.font = .systemFont(ofSize: 16)
        viewsLabel.textColor = .black
        return viewsLabel
    }()
    private let viewsCountLabel: UILabel = {
        let viewsCountLabel = UILabel()
        viewsCountLabel.translatesAutoresizingMaskIntoConstraints = false
        viewsCountLabel.text = "0"
        viewsCountLabel.font = .systemFont(ofSize: 16)
        viewsCountLabel.textColor = .black
        return viewsCountLabel
    }()
    private let viewsStackView: UIStackView = {
        let viewsStackView = UIStackView()
        viewsStackView.translatesAutoresizingMaskIntoConstraints = false
        viewsStackView.axis = .horizontal
        viewsStackView.spacing = 4
        viewsStackView.alignment = .leading
        return viewsStackView
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style,reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    private func addSubviews() {
        contentView.addSubview(authorLabel)
        contentView.addSubview(postImage)
        contentView.addSubview(descriptionLabel)
        likesStackView.addArrangedSubview(likesLabel)
        likesStackView.addArrangedSubview(likesCountLabel)
        viewsStackView.addArrangedSubview(viewsLabel)
        viewsStackView.addArrangedSubview(viewsCountLabel)
        contentView.addSubview(likesStackView)
        contentView.addSubview(viewsStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
        authorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
        authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
        authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        
        postImage.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 12),
        postImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        postImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        postImage.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
        
        descriptionLabel.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 16),
        descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
        descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
 
        likesStackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
        likesStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
        likesStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
        
        viewsStackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
        viewsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        viewsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
        ])
        
    }
    
    // MARK: - Public
    
    func update(_ model: Post) {
        authorLabel.text = model.author
        postImage.image = model.image
        descriptionLabel.text = model.description
        likesCountLabel.text = String(model.likes)
        viewsCountLabel.text = String(model.views)
    }

}
