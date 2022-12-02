//
//  BeerDetailViewController.swift
//  SearchBeer-RIBs
//
//  Created by 민도현 on 2022/11/01.
//

import RIBs
import RxSwift
import UIKit
import Then
import SnapKit

protocol BeerDetailPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class BeerDetailViewController: UIViewController, BeerDetailPresentable, BeerDetailViewControllable {

    weak var listener: BeerDetailPresentableListener?
    
    private let beerView = BeerView()
    
    override func viewDidLoad() {
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
    
    func configure(with model: BeerModel) {
        beerView.configure(with: model)
    }
}
