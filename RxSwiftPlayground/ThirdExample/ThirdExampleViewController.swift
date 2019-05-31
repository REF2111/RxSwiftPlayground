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
    
    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var secondImageView: UIImageView!
    
    let disposeBag = DisposeBag()
    
    let firstURLSession = URLSession(configuration: .default, delegate: nil, delegateQueue: nil)
    let secondURLSession = URLSession(configuration: .default, delegate: nil, delegateQueue: nil)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        navigationItem.title = "Zipping Tasks"
        
        guard let firstUrl = URL(string: "https://cdn-www.terminix.com/cs/terminix/image/groundhog%20size.jpg") else { return }
        guard let secondUrl = URL(string: "https://www.tacugama.com/wp-content/uploads/2017/12/Big-Lucy.jpg") else { return }
        
        doRxSwiftMagic(firstURL: firstUrl, secondURL: secondUrl)
    }
    
    private func doRxSwiftMagic(firstURL: URL, secondURL: URL) {
        
        let firstTask = firstURLSession.rx.data(request: URLRequest(url: firstURL))
        let secondTask = secondURLSession.rx.data(request: URLRequest(url: secondURL))
        
        Observable.zip(firstTask, secondTask) { first, second in
            return (first, second)
            }
            .retry()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] first, second in
                self?.firstImageView.image = UIImage(data: first)
                self?.secondImageView.image = UIImage(data: second)
            })
            .disposed(by: disposeBag)
    }
    
}
