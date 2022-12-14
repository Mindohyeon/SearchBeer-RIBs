//
//  RootViewController.swift
//  SearchBeer-RIBs
//
//  Created by 민도현 on 2022/10/27.
//

import RIBs
import RxSwift
import RxRelay
import UIKit
import SnapKit
import Alamofire

protocol RootPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class RootViewController: UIViewController, RootPresentable, RootViewControllable {
    
    var listener: RootPresentableListener?
    
    func present(_ viewController: UIViewController) {
        present(viewController, animated: true)
    }
}
