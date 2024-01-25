//
//  AlertController.swift
//  Navigation
//
//  Created by Миша Вашкевич on 23.01.2024.
//

import Foundation
import UIKit

public func showAlert(title: String?, message: String?, target: UIViewController, handler: ((UIAlertAction) -> Void)?) {
    
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let oklAction = UIAlertAction(title: "ok", style: .cancel)
    alertController.addAction(oklAction)
    target.present(alertController, animated: true)
}
