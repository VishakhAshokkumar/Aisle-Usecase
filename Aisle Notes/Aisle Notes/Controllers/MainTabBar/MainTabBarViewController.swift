//
//  MainTabBarViewController.swift
//  Aisle Notes
//
//  Created by Vishak on 08/07/25.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    var notesData: NotesResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeTabBarAppearance()
        addTopBorderToTabBar()
        
    }
    
    func configure(with notesData: NotesResponse) {
        self.notesData = notesData
        setupTabs()
        setBadges()
        self.selectedIndex = 1
    }
    
    private func setupTabs() {
        let discoverVC = UIViewController()
        discoverVC.view.backgroundColor = .systemBackground
        discoverVC.tabBarItem = UITabBarItem(title: "Discover", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        
        let notesVC: UIViewController
        if let notesData = notesData {
            let actualNotesVC = NotesViewController()
            actualNotesVC.notes = notesData
            notesVC = actualNotesVC
        } else {
            notesVC = UIViewController()
            notesVC.view.backgroundColor = .blue
        }
        notesVC.tabBarItem = UITabBarItem(title: "Notes", image: UIImage(systemName: "envelope.fill"), tag: 1)
        
        let matchesVC = UIViewController()
        matchesVC.view.backgroundColor = .systemBackground
        matchesVC.tabBarItem = UITabBarItem(title: "Matches", image: UIImage(systemName: "message.fill"), tag: 2)
        
        let profileVC = UIViewController()
        profileVC.view.backgroundColor = .systemBackground
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), tag: 3)
        
        viewControllers = [
            UINavigationController(rootViewController: discoverVC),
            UINavigationController(rootViewController: notesVC),
            UINavigationController(rootViewController: matchesVC),
            UINavigationController(rootViewController: profileVC)
        ]
    }
    
    
    
    private func customizeTabBarAppearance() {
        let font = UIFont.gilroyBlack(size: 10)
        
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.gray
        ]
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.black
        ]
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = normalAttributes
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = selectedAttributes
        appearance.stackedLayoutAppearance.normal.iconColor = .gray
        appearance.stackedLayoutAppearance.selected.iconColor = .black
        
        appearance.stackedLayoutAppearance.normal.badgeBackgroundColor = .systemPurple
        appearance.stackedLayoutAppearance.selected.badgeBackgroundColor = .systemPurple
        appearance.stackedLayoutAppearance.normal.badgeTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.gilroyBlack(size: 10)
        ]
        appearance.stackedLayoutAppearance.selected.badgeTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.gilroyBlack(size: 10)
        ]
        
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
    }
    
    private func addTopBorderToTabBar() {
        let border = UIView()
        border.backgroundColor = .lightGray
        border.translatesAutoresizingMaskIntoConstraints = false
        tabBar.addSubview(border)
        
        NSLayoutConstraint.activate([
            border.topAnchor.constraint(equalTo: tabBar.topAnchor),
            border.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor),
            border.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor),
            border.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
    
    private func setBadges() {
        if let notesItem = tabBar.items?[1] {
            notesItem.badgeValue = "9"
            notesItem.badgeColor = UIColor.systemPurple
        }
        
        if let matchesItem = tabBar.items?[2] {
            matchesItem.badgeValue = "50+"
            matchesItem.badgeColor = UIColor.systemPurple
        }
    }
}



