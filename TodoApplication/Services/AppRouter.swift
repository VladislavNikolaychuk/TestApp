//
//  AppRouter.swift
//  TodoApplication
//
//  Created by Vladislav Nikolaychuck on 24.07.2020.
//  Copyright © 2020 Vladislav Nikolaychuck. All rights reserved.
//

import UIKit

final class AppRouter {
    
    static func runOnLoadFlow() {
        if AuthManager.shared.token() != "" {
            AppRouter.runMainFlow()
        } else {
            AppRouter.runAuthFlow()
        }
    }
    
    static func runAuthFlow() {
        UserTypeService.shared.type = .anonymus
        AuthManager.shared.logout()
        let mainController = LoginConfigurator.createLoginRouterModule()
        let navigation = UINavigationController(rootViewController: mainController)
        changeFlowTo(controller: navigation)
    }
    
    static func runMainFlow() {
        UserTypeService.shared.type = .authorized
        let mainController = ProductsConfigurator.create()
        let navigation = UINavigationController(rootViewController: mainController)
        changeFlowTo(controller: navigation)
    }
    
    // MARK: Helpers
    static private func runFadeAnimationForWindow(_ window: UIWindow?) {
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        let options: UIView.AnimationOptions = .transitionCrossDissolve
        let duration: TimeInterval = 0.5
        UIView.transition(with: window, duration: duration,
                          options: options, animations: {},
                          completion: { _ in })
    }
    
    static func changeFlowTo(controller: UIViewController) {
        let window = UIApplication.shared.keyWindow
        window?.rootViewController = controller
        runFadeAnimationForWindow(window)
    }
}
