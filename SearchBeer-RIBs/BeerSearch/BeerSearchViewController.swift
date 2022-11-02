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
}

final class BeerSearchViewController: UIViewController, BeerSearchPresentable, BeerSearchViewControllable {
    
    weak var listener: BeerSearchPresentableListener?
    private var items = [String]()
    private var beerList: [BeerModel] = []
    private let resultTableView = UITableView()
    private let detailVC = BeerDetailViewController()
    
    private let beerImg = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .gray
    }
    
    private let beerId = UILabel().then {
        $0.font = .systemFont(ofSize: 10)
    }
    
    private let beerDescriptionLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12)
        $0.numberOfLines = 0
        $0.text = "text"
    }
    
    
    private let searchBarView = UISearchController().then {
        $0.searchBar.placeholder = "Search"
    }
    
    override func viewDidLoad() {
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Search By Id"
        
        self.searchBarView.searchBar.rx.text.orEmpty
            .debounce(RxTimeInterval.microseconds(7), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { text in
                //                self.items = beerList.description.filter { $0.hasPrefix(text) }
                self.postMethod(id: text)
                print(text)
            })
        navigationItem.searchController = searchBarView
        
        addView()
        setLayout()
    }
    
    private func addView() {
        view.addSubViews(beerImg, beerId, beerDescriptionLabel)
    }
    
    private func setLayout() {
        beerImg.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(108)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(100)
            $0.height.equalTo(150)
        }
        
        beerId.snp.makeConstraints {
            $0.top.equalTo(beerImg.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }
        
        beerDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(beerImg.snp.bottom).offset(97)
            $0.leading.trailing.equalToSuperview().inset(71)
        }
    }
    
    func configure(with beer: BeerModel) {
        let imageUrl = URL(string: beer.imageUrl)
        beerImg.kf.setImage(with: imageUrl)
        beerId.text = String(beer.id)
        beerDescriptionLabel.text = beer.description
    }
    
    func postMethod(id: String) {
        let url = "https://api.punkapi.com/v2/beers/\(id)"
        AF.request(url,
                   method: .get,
                   encoding: URLEncoding.default).responseJSON { [weak self] response in
            do {
                switch(response.result) {
                case .success(_):
                    print("jsonData = \(response)")
                    self?.beerList = try! JSONDecoder().decode([BeerModel].self, from: response.data!)
                    
                    self?.configure(with: (self?.beerList[0])!)
                    
                case .failure(let error):
                    print("error!! = \(error)")
                }
            }
        }
        
    }
}
