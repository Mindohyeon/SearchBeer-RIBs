//
//  BeerDetailInteractor.swift
//  SearchBeer-RIBs
//
//  Created by 민도현 on 2022/11/01.
//

import RIBs
import RxSwift

protocol BeerDetailRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol BeerDetailPresentable: Presentable {
    var listener: BeerDetailPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol BeerDetailListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class BeerDetailInteractor: PresentableInteractor<BeerDetailPresentable>, BeerDetailInteractable, BeerDetailPresentableListener {

    weak var router: BeerDetailRouting?
    weak var listener: BeerDetailListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: BeerDetailPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}
