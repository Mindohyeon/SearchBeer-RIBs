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
    var beerItems: PublishSubject<[BeerModel]> { get }
}

final class BeerListViewController: UIViewController, BeerListPresentable, BeerListViewControllable {
    
    weak var listener: BeerListPresentableListener?
    private let beerTableView = UITableView()
    private let disposeBag = DisposeBag()
    private let detailVC = BeerDetailViewController()
    
    override func viewDidLoad() {
        addView()
        setLayout()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Beer List"
        beerTableView.register(BeerListViewCell.self, forCellReuseIdentifier: "beerTableViewCell")
        beerTableView.rowHeight = UITableView.automaticDimension
        bindTableView()
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
    
    private func bindTableView() {
        listener?.beerItems
            .bind(to: beerTableView.rx.items(cellIdentifier: "beerTableViewCell", cellType: BeerListViewCell.self)) { (row, beer, cell) in
                cell.configure(with: beer)
            }
            .disposed(by: disposeBag)
        
        beerTableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.beerTableView.deselectRow(at: indexPath, animated: true)
                let model = self?.listener?.beerItems
            }).disposed(by: disposeBag)
    }
}

extension BeerListViewController {
    var onAppear: Observable<Void> {
        print("B")
        return self.rx.viewDidAppear
            .asObservable()
    }
}
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = BeerDetailViewController()
//        let model = beerList[indexPath.row]
//
//        vc.configure(with: model)
//
//        navigationController?.pushViewController(vc, animated: true)
//    }
//}

public extension Reactive where Base: UIViewController {
    var viewDidLoad: ControlEvent<Void> {
        let source = self.methodInvoked(#selector(Base.viewDidLoad)).map { _ in }
        return ControlEvent(events: source)
    }
    
    var viewDidAppear: ControlEvent<Void> {
        let source = methodInvoked(#selector(Base.viewDidAppear(_:))).map { _ in }
        return ControlEvent(events: source)
    }
}

