//
//  RandomBeerRouter.swift
//  SearchBeer-RIBs
//
//  Created by 민도현 on 2022/10/27.
//

import RIBs

protocol RandomBeerInteractable: Interactable {
    var router: RandomBeerRouting? { get set }
    var listener: RandomBeerListener? { get set }
}

protocol RandomBeerViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class RandomBeerRouter: ViewableRouter<RandomBeerInteractable, RandomBeerViewControllable>, RandomBeerRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: RandomBeerInteractable, viewController: RandomBeerViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
