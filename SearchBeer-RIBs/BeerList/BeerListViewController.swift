//
//  BeerListViewController.swift
//  SearchBeer-RIBs
//
//  Created by 민도현 on 2022/10/31.
//

import RIBs
import RxSwift
import UIKit
import Alamofire
import RxCocoa

protocol BeerListPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class BeerListViewController: UIViewController, BeerListPresentable, BeerListViewControllable {
    weak var listener: BeerListPresentableListener?
    var beerList: [BeerModel] = []
    private let beerTableView = UITableView()
    
    override func viewDidLoad() {
        addView()
        setLayout()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Beer List"
        beerTableView.dataSource = self
        beerTableView.delegate = self
        beerTableView.register(BeerListViewCell.self, forCellReuseIdentifier: "beerTableViewCell")
        beerTableView.rowHeight = UITableView.automaticDimension
        
        fetch()
    }
    
    private func addView() {
        view.addSubViews(beerTableView)
    }
    
    private func setLayout() {
        beerTableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(30)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    func fetch() {
        let url = "https://api.punkapi.com/v2/beers"
        AF.request(url, method: .get).responseJSON { [weak self] response in
            do {
                switch(response.result) {
                case .success(_):
                    self?.beerList = try! JSONDecoder().decode([BeerModel].self, from: response.data!)
                    
                    DispatchQueue.main.async {
                        self?.beerTableView.reloadData()
                    }
                    
                case .failure(let error):
                    print("error!! = \(error)")
                }
            }
        }.resume()
    }
}


extension BeerListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beerList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "beerTableViewCell", for: indexPath) as? BeerListViewCell else { return UITableViewCell() }
        
        let beer = beerList[indexPath.row]
        cell.configure(with: beer)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = BeerDetailViewController()
        let model = beerList[indexPath.row]
        
        vc.configure(with: model)
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

public extension Reactive where Base: UIViewController {
    var viewDidLoad: ControlEvent<Void> {
      let source = self.methodInvoked(#selector(Base.viewDidLoad)).map { _ in }
      return ControlEvent(events: source)
    }
}

