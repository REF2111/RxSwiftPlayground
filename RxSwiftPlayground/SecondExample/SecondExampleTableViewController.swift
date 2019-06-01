//
//  SecondExampleTableViewController.swift
//  RxSwiftPlayground
//
//  Created by Raphael Berendes on 30.05.19.
//  Copyright © 2019 Raphael Berendes. All rights reserved.
//

import UIKit

import RxCocoa
import RxDataSources
import RxSwift

class SecondExampleTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttonWidthConstraint: NSLayoutConstraint!
    private let disposeBag = DisposeBag()
    
    struct Dog {
        let race: String
        let age: Int
    }
    
    struct Boat {
        let name: String
        let length: Int
    }
    
    enum CellModel {
        case dog(Dog)
        case boat(Boat)
    }
    
    let sections = Observable.just([
        SectionModel(model: "Dogs", items: [
            CellModel.dog(.init(race: "Labrador", age: 13)),
            CellModel.dog(.init(race: "Australian Shepherd", age: 5))
            ]),
        SectionModel(model: "Boats", items: [
            CellModel.boat(.init(name: "Titanic", length: 269)),
            CellModel.boat(.init(name: "Grace to Glory", length: 3))
            ])
        ])
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        registerCells()
        navigationItem.title = "Table View"
        
        fillTableView()
    }
    
    private func fillTableView() {
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, CellModel>>(configureCell: { dataSource, table, indexPath, item in
            switch item {
            case .dog(let item):
                return self.dogCell(for: item)
            case .boat(let item):
                return self.boatCell(for: item)
            }
        })
        
        dataSource.titleForHeaderInSection = { dataSource, index in
            return dataSource.sectionModels[index].model
        }

        sections
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    //
    //
    //
    //
    //
    
    private func registerCells() {
        
        tableView.register(UINib(nibName: "DogTableViewCell", bundle: nil), forCellReuseIdentifier: "dogCell")
        tableView.register(UINib(nibName: "BoatTableViewCell", bundle: nil), forCellReuseIdentifier: "boatCell")
    }
    
    private func dogCell(for element: Dog) -> DogTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dogCell") as! DogTableViewCell
        cell.raceLabel.text = element.race
        cell.ageLabel.text = "\(element.age)"
        
        return cell
    }
    
    private func boatCell(for element: Boat) -> BoatTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "boatCell") as! BoatTableViewCell
        cell.nameLabel.text = element.name
        cell.lengthLabel.text = "\(element.length)"
        
        return cell
    }
    
}
