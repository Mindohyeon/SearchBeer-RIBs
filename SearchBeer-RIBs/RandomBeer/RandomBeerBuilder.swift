//
//  RandomBeerBuilder.swift
//  SearchBeer-RIBs
//
//  Created by 민도현 on 2022/10/27.
//

import RIBs

protocol RandomBeerDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class RandomBeerComponent: Component<RandomBeerDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol RandomBeerBuildable: Buildable {
    func build(withListener listener: RandomBeerListener) -> RandomBeerRouting
}

final class RandomBeerBuilder: Builder<RandomBeerDependency>, RandomBeerBuildable {

    override init(dependency: RandomBeerDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: RandomBeerListener) -> RandomBeerRouting {
        let component = RandomBeerComponent(dependency: dependency)
        let viewController = RandomBeerViewController()
        let interactor = RandomBeerInteractor(presenter: viewController)
        interactor.listener = listener
        return RandomBeerRouter(interactor: interactor, viewController: viewController)
    }
}
