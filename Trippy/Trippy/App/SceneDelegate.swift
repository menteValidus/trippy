//
//  SceneDelegate.swift
//  Trippy
//
//  Created by Denis Cherniy on 22.05.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    private var appCoordinator: AppCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else {
            return
        }

        window = UIWindow(windowScene: windowScene)
        window?.overrideUserInterfaceStyle = .light
        appCoordinator = AppCoordinator(window: window!)
        window?.makeKeyAndVisible()

        appCoordinator?.start()
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        appCoordinator?.willEnterForeground()
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        appCoordinator?.didEnterBackground()
    }
}

