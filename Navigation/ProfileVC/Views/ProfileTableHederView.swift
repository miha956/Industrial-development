//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Миша Вашкевич on 28.11.2023.
//

import Foundation
import UIKit
import SnapKit

class ProfileHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - Properties
    
    private var avatarOriginPoint = CGPoint()
    
    // MARK: - Subviews
    
    lazy var avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.image = UIImage(named: "cat")
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.layer.cornerRadius = 50
        avatarImageView.layer.borderWidth = 3
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        avatarImageView.clipsToBounds = true
        let avatarTap = UITapGestureRecognizer(
            target: self,
            action: #selector(avatarOpened))
        avatarTap.numberOfTapsRequired = 1
        avatarImageView.addGestureRecognizer(avatarTap)
        avatarImageView.isUserInteractionEnabled = true
        return avatarImageView
    }()
    let fullNameLabel: UILabel = {
        let fullNameLabel = UILabel()
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        fullNameLabel.text = "Hipster Cat"
        fullNameLabel.font = .systemFont(ofSize: 16, weight: .bold)
        fullNameLabel.textColor = .black
        return fullNameLabel
    }()
    let statusTextField: UITextField = {
        let statusTextField = UITextField()
        statusTextField.translatesAutoresizingMaskIntoConstraints = false
        statusTextField.placeholder = "Write status"
        statusTextField.textColor = .black
        statusTextField.font = .systemFont(ofSize: 15, weight: .regular)
        statusTextField.backgroundColor = .white
        statusTextField.layer.borderWidth = 1
        statusTextField.layer.borderColor = CGColor(red: 0/255,
                                                      green: 0/255,
                                                      blue: 0/255,
                                                      alpha: 1)
        statusTextField.layer.cornerRadius = 12
        let spacerView = UIView(frame:CGRect(x:0, y:0, width:10, height:10))
        statusTextField.leftViewMode = .always
        statusTextField.leftView = spacerView
        statusTextField.addTarget(nil, action: #selector(statusTextChanged(_:)), for: .editingChanged)
        return statusTextField
    }()
    let setStatusButton: UIButton = {
        let setStatusButton = UIButton(type: .system)
        setStatusButton.translatesAutoresizingMaskIntoConstraints = false
        setStatusButton.setTitle("Show status", for: .normal)
        setStatusButton.setTitleColor(.white, for: .normal)
        setStatusButton.layer.cornerRadius = 10
        setStatusButton.backgroundColor = .systemBlue
        setStatusButton.layer.shadowOffset = CGSize(
                                            width: 4,
                                            height: 4)
        setStatusButton.layer.shadowColor = CGColor(
                                            red: 0/255,
                                            green: 0/255,
                                            blue: 0/255,
                                            alpha: 1)
        setStatusButton.layer.shadowOpacity = 0.7
        setStatusButton.addTarget(nil, action: #selector(buttonPressed), for: .touchUpInside)
        return setStatusButton
    }()
    var statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.text = "Waiting for something..."
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.font = .systemFont(ofSize: 14, weight: .regular)
        statusLabel.textColor = .gray
        return statusLabel
    }()
    private lazy var avatarBackground: UIView = {
        let avatarBackground = UIView(frame: CGRect(x: 0,
                                            y: 0,
                                            width: UIScreen.main.bounds.width,
                                            height: UIScreen.main.bounds.height))
        avatarBackground.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
        avatarBackground.isHidden = true
        avatarBackground.alpha = 0
        return avatarBackground
    }()
    private lazy var closeAvatarButton: UIButton = {
        let closeAvatarButton = UIButton(type: .system)
        closeAvatarButton.translatesAutoresizingMaskIntoConstraints = false
        closeAvatarButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeAvatarButton.tintColor = .black
        closeAvatarButton.alpha = 0
        closeAvatarButton.addTarget(self, action: #selector(avatarClosed), for: .touchUpInside)
        return closeAvatarButton
    }()

    // MARK: - Lifecycle
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    // MARK: - Actions
    
    @objc func buttonPressed() {
        //print(statusLabel.text)
    }
    
    @objc func statusTextChanged(_ textField: UITextField) {
        guard let text = textField.text else { return }
        statusLabel.text = text
    }
    
    @objc func avatarOpened(target: UIView) {
        
        avatarImageView.isUserInteractionEnabled = false
        
        ProfileViewController.tableView.isScrollEnabled = false
        ProfileViewController.tableView.cellForRow(at: IndexPath(row: 0, section: 0))?.isUserInteractionEnabled = false
        
        avatarOriginPoint = avatarImageView.center
                let scale = UIScreen.main.bounds.width / avatarImageView.bounds.width
                
                UIView.animate(withDuration: 0.5) {
                    self.avatarImageView.center = CGPoint(x: UIScreen.main.bounds.midX,
                                                          y: UIScreen.main.bounds.midY - self.avatarOriginPoint.y)
                    self.avatarImageView.transform = CGAffineTransform(scaleX: scale, y: scale)
                    self.avatarImageView.layer.cornerRadius = 0
                    self.avatarBackground.isHidden = false
                    self.avatarBackground.alpha = 0.7
                } completion: { _ in
                    UIView.animate(withDuration: 0.3) {
                        self.closeAvatarButton.alpha = 1
                    }
                }
    }
    
    @objc func avatarClosed() {
        
        UIImageView.animate(withDuration: 0.5) {
                    UIImageView.animate(withDuration: 0.5) {
                        self.closeAvatarButton.alpha = 0
                        self.avatarImageView.center = self.avatarOriginPoint
                        self.avatarImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
                        self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.width / 2
                        self.avatarBackground.alpha = 0
                    }
                } completion: { _ in
                    ProfileViewController.tableView.isScrollEnabled = true
                    ProfileViewController.tableView.cellForRow(at: IndexPath(row: 0, section: 0))?.isUserInteractionEnabled = true
                    self.avatarImageView.isUserInteractionEnabled = true
                }
    }
    
    // MARK: - Private
    
    private func addSubviews() {
        self.addSubview(fullNameLabel)
        self.addSubview(statusLabel)
        self.addSubview(setStatusButton)
        self.addSubview(statusTextField)
        self.addSubview(avatarBackground)
        self.addSubview(avatarImageView)
        self.addSubview(closeAvatarButton)
    }
    
    private func setupConstraints() {
        
        let safeAreaLayoutGuide = self.safeAreaLayoutGuide
        
        avatarImageView.snp.makeConstraints { avatarImage in
            avatarImage.top.equalTo(safeAreaLayoutGuide.snp.top).offset(16)
            avatarImage.left.equalTo(self.snp.left).offset(16)
            avatarImage.height.equalTo(100)
            avatarImage.width.equalTo(100)
        }
        fullNameLabel.snp.makeConstraints { fullNameLabel in
            fullNameLabel.top.equalTo(safeAreaLayoutGuide.snp.top).offset(27)
            fullNameLabel.left.equalTo(avatarImageView.snp.right).offset(25)
        }
        setStatusButton.snp.makeConstraints { setStatusButton in
            setStatusButton.top.equalTo(avatarImageView.snp.bottom).offset(37)
            setStatusButton.right.equalTo(self.snp.right).offset(-16)
            setStatusButton.left.equalTo(self.snp.left).offset(16)
            setStatusButton.bottom.equalTo(self.snp.bottom).offset(-16)
            setStatusButton.height.equalTo(50)
        }
        statusLabel.snp.makeConstraints { statusLabel in
            statusLabel.bottom.equalTo(setStatusButton.snp.top).offset(-55)
            statusLabel.left.equalTo(avatarImageView.snp.right).offset(25)
        }
        statusTextField.snp.makeConstraints { statusTextField in
            statusTextField.top.equalTo(statusLabel.snp.bottom).offset(5)
            statusTextField.left.equalTo(avatarImageView.snp.right).offset(25)
            statusTextField.right.equalTo(safeAreaLayoutGuide.snp.right).offset(-16)
            statusTextField.height.equalTo(40)
        }
        closeAvatarButton.snp.makeConstraints { closeAvatarButton in
            closeAvatarButton.top.equalTo(avatarBackground.snp.top).offset(20)
            closeAvatarButton.right.equalTo(avatarBackground.snp.right).offset(-20)
        }
    }
}
