//
//  MainTabController.swift
//  TwitterClone
//
//  Created by Gustavo Carvalho on 17/05/22.
//

import UIKit

class MainTabController: UITabBarController {

    // MARK: - Properties
    let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(named: "AccentColor")
        button.setImage(UIImage(named: "new_tweet"), for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 56 / 2
        button.addTarget(self, action: #selector(handleFABPress), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureViewControllers()
    }
    
    // MARK: - Selectors
    @objc func handleFABPress () {
        let alert = UIAlertController(title: "The button was pressed", message: "And i'm a testing alert :D", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.addSubview(actionButton)
        
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.widthAnchor.constraint(equalToConstant: 56).isActive = true
        actionButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
        actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -64).isActive = true
        actionButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -17).isActive = true
    }
    
    func configureViewControllers() {
        let feed = FeedController()
        let feedNavigationController = templateNavigationController(rootViewController: feed, image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        
        let explore = ExploreController()
        let exploreNavigationController = templateNavigationController(rootViewController: explore, image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass"))
        
        let notifications = NotificationsController()
        let notificationNavigationController = templateNavigationController(rootViewController: notifications, image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"))
        
        let conversations = ConversationsController()
        let conversationsNavigationController = templateNavigationController(rootViewController: conversations, image: UIImage(systemName: "envelope"), selectedImage: UIImage(systemName: "envelope.fill"))
        
        viewControllers = [feedNavigationController, exploreNavigationController, notificationNavigationController, conversationsNavigationController]
        
        tabBar.isTranslucent = false
        tabBar.backgroundColor = .white
    }
    
    func templateNavigationController(rootViewController: UIViewController, image: UIImage?, selectedImage: UIImage?) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        
        let appearance = UINavigationBarAppearance();
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        
        navigationController.navigationBar.standardAppearance = appearance;
        navigationController.navigationBar.scrollEdgeAppearance = appearance;
        
        navigationController.tabBarItem.image = image
        navigationController.tabBarItem.selectedImage = selectedImage
        
        return navigationController;
    }
    
}
