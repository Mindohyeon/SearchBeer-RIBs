//
//  RootViewController.swift
//  SearchBeer-RIBs
//
//  Created by 민도현 on 2022/10/27.
//

import RIBs
import RxSwift
import UIKit
import SnapKit

protocol RootPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class RootViewController: UIViewController, RootPresentable, RootViewControllable {
    
    weak var listener: RootPresentableListener?
    private let beerTableView = UITableView()
    
    override func viewDidLoad() {
        addView()
        setLayout()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Beer List"
        beerTableView.dataSource = self
        beerTableView.register(RootViewCell.self, forCellReuseIdentifier: "beerTableViewCell")
        beerTableView.rowHeight = UITableView.automaticDimension
        beerTableView.estimatedRowHeight = UITableView.automaticDimension
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
}


extension RootViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "beerTableViewCell", for: indexPath) as? RootViewCell else { return UITableViewCell() }
        
        return cell
    }
}
