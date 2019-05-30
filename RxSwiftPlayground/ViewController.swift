//
//  ViewController.swift
//  RxSwiftPlayground
//
//  Created by Raphael Berendes on 30.05.19.
//  Copyright © 2019 Raphael Berendes. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

class ViewController: UIViewController {
    
    @IBOutlet private weak var firstNameTextField: UITextField!
    @IBOutlet private weak var lastNameTextField: UITextField!
    @IBOutlet private weak var greetingsLabel: UITextField!
    
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doObservableStuff()
    }
    
    private func doObservableStuff() {
        
        Observable.combineLatest(firstNameTextField.rx.text.orEmpty, lastNameTextField.rx.text.orEmpty) { $0 + " " + $1 }
            .map { "Moin, \($0)" }
            .bind(to: greetingsLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
}
