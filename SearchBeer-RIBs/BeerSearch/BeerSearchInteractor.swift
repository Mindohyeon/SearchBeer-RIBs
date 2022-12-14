//
//  BeerSearchInteractor.swift
//  SearchBeer-RIBs
//
//  Created by 민도현 on 2022/10/27.
//

import RIBs
import RxSwift
import Alamofire
import Foundation

protocol BeerSearchRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol BeerSearchPresentable: Presentable {
    var listener: BeerSearchPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol BeerSearchListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class BeerSearchInteractor: PresentableInteractor<BeerSearchPresentable>, BeerSearchInteractable, BeerSearchPresentableListener {
    var beerItems = PublishSubject<[BeerModel]>()
    weak var router: BeerSearchRouting?
    weak var listener: BeerSearchListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: BeerSearchPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    func postMethod(id: String) {
        let url = "https://api.punkapi.com/v2/beers/\(id)"
        AF.request(url,
                   method: .get,
                   encoding: URLEncoding.default).responseData { [weak self] response in
            do {
                switch(response.result) {
                case .success(_):
                    let beerList = try? JSONDecoder().decode([BeerModel].self, from: response.data!)
                    self?.beerItems.onNext(beerList ?? .init())
                    
                case .failure(let error):
                    print("error!! = \(error)")
                }
            }
        }.resume()
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}
