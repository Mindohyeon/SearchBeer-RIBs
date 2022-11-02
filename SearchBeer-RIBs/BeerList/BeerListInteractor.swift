//
//  BeerListInteractor.swift
//  SearchBeer-RIBs
//
//  Created by 민도현 on 2022/10/31.
//

import RIBs
import RxSwift
import RxCocoa
import Alamofire
import Foundation

protocol BeerListRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol BeerListPresentable: Presentable {
    var listener: BeerListPresentableListener? { get set }
    var beerList: [BeerModel] { get set }
    var onAppear: Observable<Void> { get }
}

protocol BeerListListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    
}

final class BeerListInteractor: PresentableInteractor<BeerListPresentable>, BeerListInteractable, BeerListPresentableListener {
    
    weak var router: BeerListRouting?
    weak var listener: BeerListListener?
    private let isfetchRelay = BehaviorRelay<Void>(value: ())
    private let disposeBag = DisposeBag()
    
    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: BeerListPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
        
        presenter.onAppear
            .bind(onNext: {
                let url = "https://api.punkapi.com/v2/beers"
                AF.request(url, method: .get).responseJSON { [weak self] response in
                    do {
                        switch(response.result) {
                        case .success(_):
                            print("this is fetch function")
                            //                    print("jsonData = \(response)")
                            self?.presenter.beerList = try! JSONDecoder().decode([BeerModel].self, from: response.data!)
                            
                            
                        case .failure(let error):
                            print("error!! = \(error)")
                        }
                    }
                }.resume()
                
            })
            .disposed(by: disposeBag)
    }
    
    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}
