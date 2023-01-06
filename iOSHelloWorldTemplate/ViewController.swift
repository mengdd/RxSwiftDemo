//
//  ViewController.swift
//  iOSHelloWorldTemplate
//
//  Created by Dandan Meng on 2022/12/15.
//

import RxSwift
import UIKit

enum MyState {
    case loading
    case content(count: Int)
    case error
}

class ViewController: UIViewController {
    private let subject = BehaviorSubject<MyState>(value: .loading)
    private let disposeBag = DisposeBag()
    private var count = 1
    override func loadView() {
        view = UIView()
        view.backgroundColor = .systemBlue
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Trigger Event", for: .normal)
        button.addTarget(self, action: #selector(onButtonTapped), for: .touchUpInside)
        stackView.addArrangedSubview(button)

        let addButton = UIButton()
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.setTitle("Add Observer", for: .normal)
        addButton.addTarget(self, action: #selector(onAddButtonTapped), for: .touchUpInside)
        stackView.addArrangedSubview(addButton)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        subject
            .subscribe {
                print("viewDidLoad observer Event:", $0)
            }
            .disposed(by: disposeBag)
    }

    @objc
    func onButtonTapped() {
        print("button tapped count: \(count)")
        subject.onNext(.content(count: count))
        count += 1
    }

    @objc
    func onAddButtonTapped() {
        print("add button tapped")
        subject
            .subscribe {
                print("Button Subscription: 1 Event:", $0)
            }
            .disposed(by: disposeBag)
    }
}
