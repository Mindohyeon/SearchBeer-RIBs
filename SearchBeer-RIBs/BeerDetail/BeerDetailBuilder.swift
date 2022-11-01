//
//  BeerDetailBuilder.swift
//  SearchBeer-RIBs
//
//  Created by 민도현 on 2022/11/01.
//

import RIBs

protocol BeerDetailDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class BeerDetailComponent: Component<BeerDetailDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol BeerDetailBuildable: Buildable {
    func build(withListener listener: BeerDetailListener) -> BeerDetailRouting
}

final class BeerDetailBuilder: Builder<BeerDetailDependency>, BeerDetailBuildable {

    override init(dependency: BeerDetailDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: BeerDetailListener) -> BeerDetailRouting {
        let component = BeerDetailComponent(dependency: dependency)
        let viewController = BeerDetailViewController()
        let interactor = BeerDetailInteractor(presenter: viewController)
        interactor.listener = listener
        return BeerDetailRouter(interactor: interactor, viewController: viewController)
    }
}
