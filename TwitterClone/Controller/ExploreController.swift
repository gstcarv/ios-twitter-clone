//
//  ExploreController.swift
//  TwitterClone
//
//  Created by Gustavo Carvalho on 17/05/22.
//

import UIKit

class ExploreController: UIViewController {

    // MARK: - Properties
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }

    // MARK: - Helpers

    func configureUI() {
        view.backgroundColor = .white
        
        navigationItem.title = "Explore"
    }
}
