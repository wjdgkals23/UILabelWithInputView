//
//  ViewController.swift
//  UILabelWithInputView
//
//  Created by 정하민 on 2020/08/22.
//  Copyright © 2020 JHM. All rights reserved.
//

import UIKit

// UIInputView
// An object that displays and manages custom input for a view when that view becomes the first responder.

// delegate 만들고 어떤 함수를 호출되게끔하면 되겠다!!

public class UILabelWithInputView: UILabel {
    // inputView는 readonly이므로 set의 역할을 할 변수가 필요합니다.
    private var contentsInputView: UIView
    // Label에 gesture를 더하고 Target Action을 통해 FirstResponder로 활성화합니다.
    private var tapGesture: UITapGestureRecognizer
    var delegate: UILabelWithInputViewDelegate?
    
    // 이제 inputView는 우리가 전달한 contentsInputView를 firstResponder가 되었을 때 노출시킵니다.
    public override var inputView: UIView? {
        return contentsInputView
    }
    
    init(inputView: UIView) {
        self.contentsInputView = inputView
        self.tapGesture = UITapGestureRecognizer()
        super.init(frame: .zero)
        
        // FirstResponder Setting
        tapGesture.addTarget(self, action: #selector(becomeFirstResponderByTap))
        self.addGestureRecognizer(tapGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UILabelWithInputView {
    // responder가 되어 inputView를 Present 하기위한 조건입니다.
    public override var canBecomeFirstResponder: Bool {
        return true
    }
    
    func valueChangedByInputView(value: String) {
        self.text = value
    }
    
    @objc public func becomeFirstResponderByTap() {
        self.becomeFirstResponder()
    }
}

public protocol UILabelWithInputViewDelegate {
    /// Change Label Text
    func valueChangedByInputView(value: String)
}

// 값을 바인딩하는 형태는 어떻게 할까??

class ViewController: UIViewController, UITextFieldDelegate {
    var customUILabel: UILabelWithInputView
    let picker = UIDatePicker()
    
    init() {
        customUILabel = UILabelWithInputView(inputView: picker)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        customUILabel = UILabelWithInputView(inputView: picker)
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(customUILabel)
        self.customUILabel.translatesAutoresizingMaskIntoConstraints = false
        customUILabel.isUserInteractionEnabled = true
        
        customUILabel.text = "DATE"
//        customUILabel.delegate = self
        
        let centerXConstraints = NSLayoutConstraint(item: customUILabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        let centerYConstraints = NSLayoutConstraint(item: customUILabel, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0)
        
        centerXConstraints.isActive = true
        centerYConstraints.isActive = true
        
        picker.addTarget(self, action: #selector(valueChanged), for: .valueChanged)
    }
}

extension ViewController {
    @objc func valueChanged() {
//        customUILabel.delegate?.valueChangedByInputView(value: picker.date.description)
        customUILabel.valueChangedByInputView(value: picker.date.description)
    }
}

extension ViewController: UILabelWithInputViewDelegate {
    func valueChangedByInputView(value: String) {
        self.customUILabel.text = value
    }
}

