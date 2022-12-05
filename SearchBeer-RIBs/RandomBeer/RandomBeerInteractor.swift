//
//  RandomBeerInteractor.swift
//  SearchBeer-RIBs
//
//  Created by 민도현 on 2022/10/27.
//

import RIBs
import RxSwift
import Alamofire
import UIKit

protocol RandomBeerRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol RandomBeerPresentable: Presentable {
    var listener: RandomBeerPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol RandomBeerListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class RandomBeerInteractor: PresentableInteractor<RandomBeerPresentable>, RandomBeerInteractable, RandomBeerPresentableListener {
    var beerItems = PublishSubject<[BeerModel]>()
    

    weak var router: RandomBeerRouting?
    weak var listener: RandomBeerListener?
    private let disposeBag = DisposeBag()

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: RandomBeerPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    func buttonAction() {
        let url = "https://api.punkapi.com/v2/beers/random"
        
        AF.request(url, method: .get).responseData { [weak self] response in
            do {
                switch response.result {
                case .success:
                    let beerList = try? JSONDecoder().decode([BeerModel].self, from: response.data!)
                    self?.beerItems.onNext(beerList ?? .init())
                case .failure(let error):
                    print("error = \(error.localizedDescription)")
                }
            }
        }
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
