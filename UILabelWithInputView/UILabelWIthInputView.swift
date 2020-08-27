//
//  UILabelWIthInputView.swift
//  UILabelWithInputView
//
//  Created by 정하민 on 2020/08/25.
//  Copyright © 2020 JHM. All rights reserved.
//

import Foundation
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
