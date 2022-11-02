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
    
    override func viewDidLoad() {
        view.backgroundColor = .white
    }
    
    func present(viewControllers: [UIViewController]) {
            setViewControllers(viewControllers, animated: true)
    //        present(viewController, animated: true, completion: nil)
        }
}
