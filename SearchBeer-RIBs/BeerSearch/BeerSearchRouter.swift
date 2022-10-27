//
//  BeerSearchRouter.swift
//  SearchBeer-RIBs
//
//  Created by 민도현 on 2022/10/27.
//

import RIBs

protocol BeerSearchInteractable: Interactable {
    var router: BeerSearchRouting? { get set }
    var listener: BeerSearchListener? { get set }
}

protocol BeerSearchViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class BeerSearchRouter: ViewableRouter<BeerSearchInteractable, BeerSearchViewControllable>, BeerSearchRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: BeerSearchInteractable, viewController: BeerSearchViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
