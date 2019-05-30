//
//  SecondExampleTableViewController.swift
//  RxSwiftPlayground
//
//  Created by Raphael Berendes on 30.05.19.
//  Copyright © 2019 Raphael Berendes. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

struct Dog {
    
    let race: String
    let age: Int
}

class SecondExampleTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttonWidthConstraint: NSLayoutConstraint!
    private let disposeBag = DisposeBag() // FIXME: What does he do?
    
    private let dogs: [Dog] = [
        
        Dog(race: "Labrador", age: 13),
        Dog(race: "Australian Shepherd", age: 5),
        Dog(race: "Bobtail", age: 2)
    ]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        navigationItem.title = "Second Example"
        tableView.register(UINib(nibName: "DogTableViewCell", bundle: nil), forCellReuseIdentifier: "dogCell")
        
        doRxSwiftMagic()
        
    }
    
    deinit {
        // Dispose bag was emptied
    }
    
    private func doRxSwiftMagic() {
        
        let items = Observable.just(dogs)
        
        items
            .bind(to: tableView.rx.items(cellIdentifier: "dogCell", cellType: DogTableViewCell.self)) { (row, dog, cell) in
                cell.raceLabel.text = dog.race
                cell.ageLabel.text = "\(dog.age)"
            }
            .disposed(by: disposeBag)
        
        tableView.rx
            .modelSelected(Dog.self)
            .subscribe(onNext: { [weak self] dog in
                let alertController = UIAlertController(title: dog.race, message: "\(dog.age)", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default))
                self?.present(alertController, animated: true)
            })
            .disposed(by: disposeBag)
        
        tableView.rx.contentOffset
            .map { $0.y + 100 }
            .bind(to: buttonWidthConstraint.rx.constant)
            .disposed(by: disposeBag)
    }
    
}
