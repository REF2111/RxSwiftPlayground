//
//  ThirdExampleViewController.swift
//  RxSwiftPlayground
//
//  Created by Raphael Berendes on 30.05.19.
//  Copyright © 2019 Raphael Berendes. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class ThirdExampleViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    let disposeBag = DisposeBag()
    
    var bla: Any?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        navigationItem.title = "Third Example"
        
        
        guard let url = URL(string: "https://i.pinimg.com/originals/e8/52/a3/e852a3670390e302f70bc0154ebeff20.jpg") else { return }
        doRxSwiftMagic(with: url)
    }
    
    private func doRxSwiftMagic(with url: URL) {
        
        URLSession.shared.rx.data(request: URLRequest(url: url))
            .retry(3)
            .map { data in
                UIImage(data: data)
            }
            .subscribe(imageView.rx.image)
            .disposed(by: disposeBag)
    }

}
