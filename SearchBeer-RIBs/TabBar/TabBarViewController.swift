//
//  TabBarViewController.swift
//  SearchBeer-RIBs
//
//  Created by 민도현 on 2022/10/27.
//

import RIBs
import RxSwift
import UIKit

protocol TabBarPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class TabBarViewController: UITabBarController, TabBarPresentable, TabBarViewControllable {

    weak var listener: TabBarPresentableListener?
    private let rootVC = BeerListViewController()
    private let beerSearchVC = BeerSearchViewController()
    private let randomVC = RandomBeerViewController()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        rootVC.tabBarItem = UITabBarItem(title: "BeerList", image: UIImage(systemName: "1.circle.fill")?.withTintColor(.black), tag: 0)
        beerSearchVC.tabBarItem = UITabBarItem(title: "BeerSearch", image: UIImage(systemName: "2.circle.fill")?.withTintColor(.black), tag: 1)
        randomVC.tabBarItem = UITabBarItem(title: "randomBeer", image: UIImage(systemName: "3.circle.fill")?.withTintColor(.black), tag: 2)
        
        let rootNavVC = UINavigationController(rootViewController: rootVC)
        let beerSearchNavVC = UINavigationController(rootViewController: beerSearchVC)
        let randomNavVC = UINavigationController(rootViewController: randomVC)
        
        self.viewControllers = [rootNavVC, beerSearchNavVC, randomNavVC]
    }
}
