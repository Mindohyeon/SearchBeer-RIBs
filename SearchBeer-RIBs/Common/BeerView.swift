//
//  BeerView.swift
//  SearchBeer-RIBs
//
//  Created by 민도현 on 2022/12/02.
//

import UIKit
import SnapKit
import Then

final class BeerView: UIView {
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func addView() {
        self.addSubViews(beerImg, beerId, beerDescriptionLabel)
    }
    
    private func setLayout() {
        beerImg.snp.makeConstraints{
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(108)
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
