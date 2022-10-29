//
//  RootViewCell.swift
//  SearchBeer-RIBs
//
//  Created by 민도현 on 2022/10/27.
//

import UIKit
import Then
import SnapKit
import Kingfisher

class RootViewCell: UITableViewCell {
    private let beerImg = UIImageView().then {
        $0.backgroundColor = .gray
    }
    
    private let beerDescriptionLabel = UILabel().then {
        $0.text = "text"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addView() {
        contentView.addSubViews(beerImg, beerDescriptionLabel)
    }
    
    private func setLayout() {
        beerImg.snp.makeConstraints {
            $0.top.equalTo(10)
            $0.leading.equalTo(30)
            $0.bottom.equalToSuperview().inset(3)
            $0.size.equalTo(80)
        }
        
        beerDescriptionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(10)
            $0.leading.equalTo(beerImg.snp.trailing).offset(10)
        }
    }
    
    func configure(with beer: BeerModel) {
        let imageUrl = URL(string: beer.imageUrl)
        beerImg.kf.setImage(with: imageUrl)
        print("hihi")
        beerDescriptionLabel.text = beer.description
    }
}
