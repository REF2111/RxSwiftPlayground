//
//  FifthExampleViewController.swift
//  RxSwiftPlayground
//
//  Created by Raphael Berendes on 01.06.19.
//  Copyright © 2019 Raphael Berendes. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

class FifthExampleViewController: UIViewController {

    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        navigationItem.title = "Throttle API Calls"

        doRxSwiftMagic()
    }
    

    private func doRxSwiftMagic() {
        
        searchField.rx.text.orEmpty
            .throttle(.milliseconds(3000), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest { [weak self] query in
                (self?.fetchResults(from: query))!
                .retry(3)
                .startWith()
                .catchErrorJustReturn("")
            }
            .subscribe(onNext: { [weak self] result in
                self?.resultLabel.text = result
                self?.resetResultLabel()
            })
            .disposed(by: disposeBag)
        
    }
    
    private func fetchResults(from query: String) -> Observable<String> {
        
        return Observable.of("New data")
    }
    
    private func resetResultLabel() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.resultLabel.text = ""
        }
    }

}
