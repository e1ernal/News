//
//  AppDelegate.swift
//  News
//
//  Created by e1ernal on 12.07.2024.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        configure(window)
        return true
    }
    
    private func configure(_ window: UIWindow) {
        let viewController = ArticlesViewController() /* Поменять потом на Launch Screen */
        let navigationController = UINavigationController()
        navigationController.viewControllers = [viewController]
        
        // Disable transparent Navigation Bar and fill it with background color
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().backgroundColor = .clear
        
        self.window = window
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
}
