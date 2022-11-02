//
//  TabBarRouter.swift
//  SearchBeer-RIBs
//
//  Created by 민도현 on 2022/10/27.
//
import UIKit
import RIBs

protocol TabBarInteractable: Interactable, BeerListListener, BeerSearchListener, RandomBeerListener {
    var router: TabBarRouting? { get set }
    var listener: TabBarListener? { get set }
}

protocol TabBarViewControllable: ViewControllable {
    func present(viewControllers: [UIViewController])
}

final class TabBarRouter: ViewableRouter<TabBarInteractable, TabBarViewControllable>, TabBarRouting {

    private let beerListBuilder: BeerListBuildable
    private let beerSearchBuilder: BeerSearchBuildable
    private let beerRandomBuilder: RandomBeerBuildable
    // TODO: Constructor inject child builder protocols to allow building children.
    init(
        interactor: TabBarInteractable,
        viewController: TabBarViewControllable,
        beerListBuilder: BeerListBuildable,
        beerSearchBuilder: BeerSearchBuildable,
        beerRandomBuilder: RandomBeerBuildable
    ) {
        self.beerListBuilder = beerListBuilder
        self.beerSearchBuilder = beerSearchBuilder
        self.beerRandomBuilder = beerRandomBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    override func didLoad() {
        super.didLoad()
        let listRouter = beerListBuilder.build(withListener: interactor)
        let listNav = UINavigationController(rootViewController: listRouter.viewControllable.uiviewController)
        listNav.tabBarItem = UITabBarItem(title: "BeerList", image: UIImage(systemName: "1.circle.fill")?.withTintColor(.black), tag: 0)
        attachChild(listRouter)
        
        let searchRouter = beerSearchBuilder.build(withListener: interactor)
        let searchNav = UINavigationController(rootViewController: searchRouter.viewControllable.uiviewController)
        searchNav.tabBarItem = UITabBarItem(title: "BeerSearch", image: UIImage(systemName: "2.circle.fill")?.withTintColor(.black), tag: 1)
        attachChild(searchRouter)
        
        let randomRouter = beerRandomBuilder.build(withListener: interactor)
        let randomNav = UINavigationController(rootViewController: randomRouter.viewControllable.uiviewController)
        randomNav.tabBarItem = UITabBarItem(title: "randomBeer", image: UIImage(systemName: "3.circle.fill")?.withTintColor(.black), tag: 2)
        attachChild(randomRouter)
        
        viewController.present(viewControllers: [listNav, searchNav, randomNav])
    }
}
