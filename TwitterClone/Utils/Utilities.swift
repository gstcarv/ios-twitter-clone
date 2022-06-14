//
//  Utilities.swift
//  TwitterClone
//
//  Created by Gustavo Carvalho on 08/06/22.
//

import UIKit

class Utilities {
    
    func inputContainerView(withImage image: UIImage, textField: UITextField) -> UIView {
        let view = UIView()
        
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let iv = UIImageView()
        iv.image = image
        
        view.addSubview(iv)
        
        iv.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iv.leftAnchor.constraint(equalTo: view.leftAnchor),
            iv.topAnchor.constraint(equalTo: view.topAnchor, constant: 12),
            iv.widthAnchor.constraint(equalToConstant: 27),
            iv.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        view.addSubview(textField)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.leftAnchor.constraint(equalTo: iv.rightAnchor, constant: 8),
            textField.topAnchor.constraint(equalTo: view.topAnchor, constant: 13.5),
            textField.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
        
        let dividerView = UIView()
        dividerView.backgroundColor = .white
        
        view.addSubview(dividerView)
        
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dividerView.heightAnchor.constraint(equalToConstant: 0.7),
            dividerView.rightAnchor.constraint(equalTo: view.rightAnchor),
            dividerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            dividerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5),
        ])
        
        return view;
    }
    
    func textField(withPlaceholder placeholder: String) -> UITextField {
        let tf = UITextField()
        tf.textColor = .white
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ])
        return tf;
    }
    
    func attributedButton(_ firstPart: String, _ secondPart: String) -> UIButton {
        let button = UIButton(type: .system)
        
        let attributedTitle = NSMutableAttributedString(string: firstPart, attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ])
        
        
        let secondTitle = NSMutableAttributedString(string: secondPart, attributes: [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ])
        
        attributedTitle.append(secondTitle)
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        return button;
    }
    
}
