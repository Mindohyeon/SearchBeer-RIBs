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
    
    override func viewDidLoad() {
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
}
