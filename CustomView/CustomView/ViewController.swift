//
//  ViewController.swift
//  CustomView
//
//  Created by Vasiliy Shannikov on 26.02.2024.
//

import UIKit
import SnapKit

class ViewController: UIViewController, GreenViewDelegate {
    private lazy var someLabel: UILabel = {
        let label = UILabel()
        label.text = "default label text"
        label.textColor = .black
        label.font = .systemFont(ofSize: 22, weight: .semibold)

        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red

        let greenCustomView = SomeView()
        greenCustomView.textForChange = "Changed title"
        greenCustomView.configureLabel(with: "Custom text")
        greenCustomView.delegate = self

//        greenCustomView.onChangeColorButtonPressed = { [weak self] in
//            self?.view.backgroundColor = .yellow
//        }

//        greenCustomView.onChangeVCLabelButtonPressed = { [weak self] greenViewText in
//            self?.someLabel.text = greenViewText
//        }

        [greenCustomView, someLabel].forEach { view.addSubview($0) }

        greenCustomView.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(400)
            make.topMargin.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
        }

        someLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(greenCustomView.snp.bottom).offset(50)
        }
    }

    func changeVCBackground(with color: UIColor) {
        view.backgroundColor = color
    }

    func changeVCLabelText(with text: String) {
        someLabel.text = text
    }
}


