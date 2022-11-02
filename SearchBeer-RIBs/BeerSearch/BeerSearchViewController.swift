//
//  BeerSearchViewController.swift
//  SearchBeer-RIBs
//
//  Created by 민도현 on 2022/10/27.
//

import RIBs
import RxSwift
import UIKit
import Then
import SnapKit

protocol BeerSearchPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class BeerSearchViewController: UIViewController, BeerSearchPresentable, BeerSearchViewControllable {
    
    weak var listener: BeerSearchPresentableListener?
    private var items = [String]()
    private let beerList: [BeerModel] = []
    private let resultTableView = UITableView()
    
    
    private let searchBarView = UISearchController().then {
        $0.searchBar.placeholder = "Search"
    }
    
    override func viewDidLoad() {
        
        self.searchBarView.searchBar.rx.text.orEmpty
            .debounce(RxTimeInterval.microseconds(2), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { text in
//                self.items = beerList.description.filter { $0.hasPrefix(text) }
            })
        navigationItem.searchController = searchBarView
    }
}
