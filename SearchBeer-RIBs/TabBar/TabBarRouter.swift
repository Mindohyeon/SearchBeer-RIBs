//
//  TabBarRouter.swift
//  SearchBeer-RIBs
//
//  Created by 민도현 on 2022/10/27.
//

import RIBs

protocol TabBarInteractable: Interactable {
    var router: TabBarRouting? { get set }
    var listener: TabBarListener? { get set }
}

protocol TabBarViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class TabBarRouter: LaunchRouter<TabBarInteractable, TabBarViewControllable>, TabBarRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: TabBarInteractable, viewController: TabBarViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
