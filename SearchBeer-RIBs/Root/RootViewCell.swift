//
//  RootViewCell.swift
//  SearchBeer-RIBs
//
//  Created by 민도현 on 2022/10/27.
//

import UIKit
import Then
import SnapKit

class RootViewCell: UITableViewCell {
    private let beerImg = UIImageView().then {
        $0.backgroundColor = .gray
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addView() {
    }
}
