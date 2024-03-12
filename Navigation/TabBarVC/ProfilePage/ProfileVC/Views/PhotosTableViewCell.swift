//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Миша Вашкевич on 12.12.2023.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    private enum Constants {
        static let titleLabelSpacing: CGFloat = 12.0
        static let detailButtonTralling: CGFloat = -12.0
        static let photoSpacing: CGFloat = 8
    }
    
    // MARK: - Subviews
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Photos"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        titleLabel.textColor = .black
        return titleLabel
    }()
    private lazy var detailButton: UIButton = {
        let detailButton = UIButton()
        detailButton.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        detailButton.tintColor = .black
        detailButton.translatesAutoresizingMaskIntoConstraints = false
        return detailButton
    }()
    private lazy var photoStackView: UIStackView = {
        let photoStackView = UIStackView()
        photoStackView.translatesAutoresizingMaskIntoConstraints = false
        photoStackView.axis = .horizontal
        photoStackView.spacing = 8
        photoStackView.alignment = .fill
        return photoStackView
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
        contentView.addSubview(titleLabel)
        contentView.addSubview(detailButton)
        contentView.addSubview(photoStackView)
        for _ in 1...4 {
            let photo = UIImageView()
            photo.layer.cornerRadius = 6
            photo.clipsToBounds = true
            photo.contentMode = .scaleAspectFill
            photoStackView.addArrangedSubview(photo)
        }
    }
    
    private func setupConstraints() {
        
        for view in photoStackView.arrangedSubviews {
            NSLayoutConstraint.activate([
                view.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 48) / 4),
                view.widthAnchor.constraint(equalTo: view.heightAnchor)
            ])
        }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.titleLabelSpacing),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.titleLabelSpacing),
            
            detailButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            detailButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.detailButtonTralling),
            
            photoStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.titleLabelSpacing),
            photoStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.titleLabelSpacing),
            photoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.detailButtonTralling),
            photoStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.detailButtonTralling)
        ])
    }
    
    // MARK: - Public
    
    func updateData(photos :[UIImage?]) {
        var index = 0
        for view in photoStackView.arrangedSubviews {
            if let item = view as? UIImageView {
                item.image = photos[index]
                index += 1
            }
        }
    }
}

