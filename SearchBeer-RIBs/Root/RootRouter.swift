//
//  RootRouter.swift
//  SearchBeer-RIBs
//
//  Created by 민도현 on 2022/10/27.
//

import RIBs
import UIKit

protocol RootInteractable: Interactable, TabBarListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    func present(_ viewController: UIViewController)
    
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {

    private let tabBarBuilder: TabBarBuildable
    
    private var tabBar: ViewableRouting?
    
    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: RootInteractable, viewController: RootViewControllable, tabBarBuilder: TabBarBuildable) {
        self.tabBarBuilder = tabBarBuilder
        super.init(interactor: interactor, viewController: viewController)
        
        interactor.router = self
    }

    override func didLoad() {
        routeToTabBarPresent()
    }
    
    private func routeToTabBarPresent() {
        let tabBar = tabBarBuilder.build(withListener: interactor)
        self.tabBar = tabBar
        attachChild(tabBar)
        let vc = tabBar.viewControllable.uiviewController
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        
        viewController.present(vc)
    }
    
}
