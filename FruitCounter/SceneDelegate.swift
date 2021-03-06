//
//  SceneDelegate.swift
//  FruitCounter
//
//  Created by Ken Krzeminski on 7/3/20.
//  Copyright © 2020 Ken Krzeminski. All rights reserved.
//

import UIKit
import SwiftUI

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private let usernameKey = "userName"

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

        // Create the SwiftUI view that provides the window contents.
        
        let dataCoordinator = DataCoordinator()
        
        dataCoordinator.fetchLatest(loadSubscriber: DataLoadSubscriber { [weak self] result in
            switch result {
            case .success(let data):
                if let logBook = try? JSONDecoder().decode(LogBook.self, from: data) {
                    self?.launch(with: logBook, dataCoordinator: dataCoordinator, scene: scene)
                }
            case .failure(let error):
                print(error)
                self?.launch(with: .default, dataCoordinator: dataCoordinator, scene: scene)
            }
        })
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

    private func launch(with logBook: LogBook, dataCoordinator: DataCoordinator, scene: UIScene) {
        let logCoordinator = LogCoordinator(logBook: logBook, dataCoordinator: dataCoordinator)
        let counterViewModel = CounterViewModel(logCoordinator: logCoordinator, font: .appBoldFont(size: 69.0))
        
        let fruitLogListViewModel = FruitLogListViewModel(logCoordinator: logCoordinator, fruit: logCoordinator.currentLogBook.focusedFruit, font: .appFont(size: 18))
        let view = MainView(maxBottomViewRatio: 0.5, counterViewModel: counterViewModel, listViewModel: fruitLogListViewModel)
        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: view)
            self.window = window
            window.makeKeyAndVisible()
        }
    }

}

