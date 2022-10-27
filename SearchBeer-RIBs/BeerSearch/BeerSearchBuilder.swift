//
//  BeerSearchBuilder.swift
//  SearchBeer-RIBs
//
//  Created by 민도현 on 2022/10/27.
//

import RIBs

protocol BeerSearchDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class BeerSearchComponent: Component<BeerSearchDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol BeerSearchBuildable: Buildable {
    func build(withListener listener: BeerSearchListener) -> BeerSearchRouting
}

final class BeerSearchBuilder: Builder<BeerSearchDependency>, BeerSearchBuildable {

    override init(dependency: BeerSearchDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: BeerSearchListener) -> BeerSearchRouting {
        let component = BeerSearchComponent(dependency: dependency)
        let viewController = BeerSearchViewController()
        let interactor = BeerSearchInteractor(presenter: viewController)
        interactor.listener = listener
        return BeerSearchRouter(interactor: interactor, viewController: viewController)
    }
}
