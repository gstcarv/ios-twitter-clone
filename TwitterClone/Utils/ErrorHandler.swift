//
//  ErrorHandler.swift
//  TwitterClone
//
//  Created by Gustavo Carvalho on 30/06/22.
//

import Foundation
import UIKit

class ErrorHandler {
    static func handleError(_ context: UIViewController, err: Error?, message: String? = "An error occurs. Try again later") {
        let alert = UIAlertController.init(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        context.present(alert, animated: true, completion: nil)
    }
}
