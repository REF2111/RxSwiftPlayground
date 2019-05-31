//
//  FourthExampleViewController.swift
//  RxSwiftPlayground
//
//  Created by Raphael Berendes on 31.05.19.
//  Copyright © 2019 Raphael Berendes. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

class FourthExampleViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Fourth Example"
        
        doRxSwiftMagic()
    }
        
    private func doRxSwiftMagic() {
        
        view.rx.observe(UIColor.self, "backgroundColor")
            .subscribe { color in
                guard
                    let color = color.element,
                    let unwrappedColor = color else { return }
                debugPrint("New color is \(unwrappedColor)")
            }
            .disposed(by: disposeBag)
        
        NotificationCenter.default.rx.notification(UIApplication.willEnterForegroundNotification)
            .subscribe { [weak self] notification in
                self?.view.backgroundColor = .orange
            }
            .disposed(by: disposeBag)
    }
    
}
