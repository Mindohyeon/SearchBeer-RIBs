//
//  RandomBeerViewController.swift
//  SearchBeer-RIBs
//
//  Created by 민도현 on 2022/10/27.
//

import RIBs
import RxSwift
import RxCocoa
import UIKit

protocol RandomBeerPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    var beerItems: PublishSubject<[BeerModel]> { get set }
    func buttonAction()
}

final class RandomBeerViewController: UIViewController, RandomBeerPresentable, RandomBeerViewControllable {
    
    weak var listener: RandomBeerPresentableListener?
    private let beerView = BeerView()
    private let disposeBag = DisposeBag()
    
    private lazy var randomButton = UIButton().then {
        $0.setTitle("reset", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 10)
        $0.layer.cornerRadius = 20
        $0.backgroundColor = UIColor(red: 0.05, green: 0.63, blue: 1, alpha: 1)
    }
    
    override func viewDidLoad() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "RandomBeer"
        
        addView()
        setLayout()
        
        randomButton.rx.tap.bind { [weak self] in
            self?.listener?.buttonAction()
            
        }.disposed(by: disposeBag)
        
        listener?.beerItems.bind { [weak self] modelData in
            self?.beerView.configure(with: modelData[0])
        }.disposed(by: disposeBag)
    }
    
    private func addView() {
        view.addSubViews(beerView, randomButton)
    }
    
    private func setLayout() {
        beerView.snp.makeConstraints {
            $0.top.leading.bottom.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        randomButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-80)
            $0.leading.trailing.equalToSuperview().inset(136)
            $0.height.equalTo(37)
        }
    }
}
