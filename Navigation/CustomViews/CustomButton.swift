//
//  CustomButton.swift
//  Navigation
//
//  Created by Миша Вашкевич on 26.01.2024.
//

import UIKit

final class CustomButton: UIButton {
    
    // MARK: - Properties
    
    private var completionHandler: (() -> Void)?
    
    // MARK: - Lifecycle
    
    
    init(title: String, titleColor: UIColor, completion: @escaping () -> Void ) {
        super.init(frame: .zero)
        
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.completionHandler = completion
        self.addTarget(nil, action: #selector(buttonTapped), for: .touchUpInside)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc private func buttonTapped() {
        guard let completion = completionHandler else {return}
        completion()
    }
    
}
