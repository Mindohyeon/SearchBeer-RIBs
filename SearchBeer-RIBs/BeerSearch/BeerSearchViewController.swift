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
import Alamofire

protocol BeerSearchPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    var beerItems: PublishSubject<[BeerModel]> { get set }
    func postMethod(id: String)
}

final class BeerSearchViewController: UIViewController, BeerSearchPresentable, BeerSearchViewControllable {
    
    weak var listener: BeerSearchPresentableListener?
    private var beerList: [BeerModel] = []
    private let disposeBag = DisposeBag()
    private let beerView = BeerView()
    
    private let searchBarView = UISearchController().then {
        $0.searchBar.placeholder = "id 로 검색"
    }
    
    override func viewDidLoad() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Search By Id"
        
        self.searchBarView.searchBar.rx.text.orEmpty
            .debounce(RxTimeInterval.microseconds(7), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .bind { [weak self] text in
                self?.listener?.postMethod(id: text)
                
                self?.listener?.beerItems.bind { [weak self] searchData in
                    self?.beerView.configure(with: searchData[0])
                }.disposed(by: self!.disposeBag)
            }.disposed(by: disposeBag)
        navigationItem.searchController = searchBarView
        
        addView()
        setLayout()
    }
    
    private func addView() {
        view.addSubViews(beerView)
    }
    
    private func setLayout() {
        beerView.snp.makeConstraints {
            $0.top.leading.bottom.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configure(with model: BeerModel) {
        beerView.configure(with: model)
    }
}
