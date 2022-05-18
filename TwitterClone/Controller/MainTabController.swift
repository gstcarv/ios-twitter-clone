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
        feed.tabBarItem.image = UIImage(systemName: "house")
        feed.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        
        let explore = ExploreController()
        explore.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        
        let notifications = NotificationsController()
        notifications.tabBarItem.image = UIImage(systemName: "heart")
        notifications.tabBarItem.selectedImage = UIImage(systemName: "heart.fill")
        
        let conversations = ConversationsController()
        conversations.tabBarItem.image = UIImage(systemName: "envelope")
        conversations.tabBarItem.selectedImage = UIImage(systemName: "envelope.fill")
        
        viewControllers = [feed, explore, notifications, conversations]
    }
    
}
