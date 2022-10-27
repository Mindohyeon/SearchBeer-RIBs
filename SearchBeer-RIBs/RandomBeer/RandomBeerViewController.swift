//
//  RandomBeerViewController.swift
//  SearchBeer-RIBs
//
//  Created by 민도현 on 2022/10/27.
//

import RIBs
import RxSwift
import UIKit

protocol RandomBeerPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class RandomBeerViewController: UIViewController, RandomBeerPresentable, RandomBeerViewControllable {

    weak var listener: RandomBeerPresentableListener?
}
