//
//  TabBarBuilder.swift
//  SearchBeer-RIBs
//
//  Created by 민도현 on 2022/10/27.
//

import RIBs

protocol TabBarDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class TabBarComponent: Component<TabBarDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol TabBarBuildable: Buildable {
    func build() -> LaunchRouting
}

final class TabBarBuilder: Builder<TabBarDependency>, TabBarBuildable {

    override init(dependency: TabBarDependency) {
        super.init(dependency: dependency)
    }

    func build() -> LaunchRouting {
        let component = TabBarComponent(dependency: dependency)
        let viewController = TabBarViewController()
        let interactor = TabBarInteractor(presenter: viewController)
        return TabBarRouter(interactor: interactor, viewController: viewController)
    }
}
