//
//  BeerDetailRouter.swift
//  SearchBeer-RIBs
//
//  Created by 민도현 on 2022/11/01.
//

import RIBs

protocol BeerDetailInteractable: Interactable {
    var router: BeerDetailRouting? { get set }
    var listener: BeerDetailListener? { get set }
}

protocol BeerDetailViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class BeerDetailRouter: ViewableRouter<BeerDetailInteractable, BeerDetailViewControllable>, BeerDetailRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: BeerDetailInteractable, viewController: BeerDetailViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
