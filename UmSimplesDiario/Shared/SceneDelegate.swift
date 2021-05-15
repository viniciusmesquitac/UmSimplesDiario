//
//  SceneDelegate.swift
//  UmSimplesDiario
//
//  Created by Vinicius Mesquita on 08/02/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.windowScene = windowScene
        coordinator = AppCoordinator(window: window)
        coordinator?.start()
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        if UserDefaults.standard.bool(forKey: DefaultsEnum.isBiometricActive.rawValue) {
            BiometricAuthentication().identify { success, _ in
                if !success { exit(EXIT_SUCCESS) }
            }
        }
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}
