//
//  MainTabController.swift
//  TwitterClone
//
//  Created by Gustavo Carvalho on 17/05/22.
//

import UIKit

class MainTabController: UITabBarController {

    // MARK: - Properties
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewControllers()
    }
    
    // MARK: - Helpers
    
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
