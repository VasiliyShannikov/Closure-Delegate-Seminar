//
//  SomeView.swift
//  CustomView
//
//  Created by Vasiliy Shannikov on 26.02.2024.
//

import UIKit
import SnapKit

protocol GreenViewDelegate: AnyObject {
    func changeVCBackground(with color: UIColor)
    func changeVCLabelText(with text: String)
}

class SomeView: UIView {
    var textForChange: String?
    var onChangeColorButtonPressed: (() -> Void)?
    var onChangeVCLabelButtonPressed: ((String) -> Void)?
    weak var delegate: GreenViewDelegate?

    private let textField: UITextField = {
        let field = UITextField()
        field.placeholder = "Input field"

        return field
    }()

    private lazy var title: UILabel  = {
        let label = UILabel()
        label.text = "default text"

        return label
    }()

    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Change color", for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(changeColorButtonPressed), for: .touchUpInside)

        return button
    }()

    private lazy var changeLabelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Change title", for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(changeTextButtonPressed), for: .touchUpInside)

        return button
    }()

    private lazy var changeVCLabelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Change ViewController label", for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(changeVCTextButtonPressed), for: .touchUpInside)

        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        title.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        button.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(20)
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
        }

        changeLabelButton.snp.makeConstraints { make in
            make.top.equalTo(button.snp.bottom).offset(20)
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
        }

        changeVCLabelButton.snp.makeConstraints { make in
            make.top.equalTo(changeLabelButton.snp.bottom).offset(20)
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
        }

        textField.snp.makeConstraints { make in
            make.topMargin.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
        }


    }
    func configureLabel(with text: String) {
        title.text = text
    }

    private func setupView() {
        self.backgroundColor = .green
        self.layer.cornerRadius = 8
        [title, button, changeLabelButton, changeVCLabelButton, textField].forEach { self.addSubview($0) }
    }

    @objc private func changeColorButtonPressed() {
//        onChangeColorButtonPressed?()
        delegate?.changeVCBackground(with: .cyan)
    }

    @objc private func changeTextButtonPressed() {
        title.text = textForChange

    }

    @objc private func changeVCTextButtonPressed() {
        guard let text = textField.text, !text.isEmpty else { return }

//        onChangeVCLabelButtonPressed?(text)
        delegate?.changeVCLabelText(with: text)
    }
}
