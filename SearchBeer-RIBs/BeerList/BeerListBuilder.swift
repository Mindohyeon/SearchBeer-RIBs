//
//  BeerListBuilder.swift
//  SearchBeer-RIBs
//
//  Created by 민도현 on 2022/10/31.
//

import RIBs

protocol BeerListDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class BeerListComponent: Component<BeerListDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol BeerListBuildable: Buildable {
    func build(withListener listener: BeerListListener) -> BeerListRouting
}

final class BeerListBuilder: Builder<BeerListDependency>, BeerListBuildable {

    override init(dependency: BeerListDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: BeerListListener) -> BeerListRouting {
        let component = BeerListComponent(dependency: dependency)
        let viewController = BeerListViewController()
        let interactor = BeerListInteractor(presenter: viewController)
        interactor.listener = listener
        return BeerListRouter(interactor: interactor, viewController: viewController)
    }
}
