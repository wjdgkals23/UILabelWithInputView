//
//  OptionPicker.swift
//  UILabelWithInputView
//
//  Created by 정하민 on 2020/08/25.
//  Copyright © 2020 JHM. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

// multiple한 value를 closure로 받아서 한번에 처리하는 함수!
//protocol

class OptionPicker: UIView {
    let stackView = UIStackView()
    let pickerTitle = UILabel()
    
    let buttonStackView = UIStackView()
    let button1 = UIButton()
    let button2 = UIButton()
    
    init() {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        buttonStackView.addArrangedSubViews(views: [button1, button2])
        stackView.addArrangedSubViews(views: [pickerTitle, buttonStackView])
        
        stackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        stackView.axis = .horizontal
        stackView.spacing = 8
        
        buttonStackView.axis = .horizontal
        buttonStackView.spacing = 4
        
        button1.setTitle("현금", for: .normal)
        button2.setTitle("카드", for: .normal)
    }
}

extension UIView {
    func addSubViews(views: [UIView]) {
        views.forEach { [weak self] view in
            self?.addSubview(view)
        }
    }
}

extension UIStackView {
    func addArrangedSubViews(views: [UIView]) {
        views.forEach { [weak self] view in
            self?.addArrangedSubview(view)
        }
    }
}
