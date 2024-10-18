//
//  CustomView.swift
//  HW26
//
//  Created by  Ivan Kiskyak on 17.10.24.
//

import UIKit

protocol ICustomViewDelegate {
    func sendName(_ name: String)
}

class CustomView: UIView {
    
    var nameInstance: String?
    var delegate: ICustomViewDelegate?
    
    init(bgColor: UIColor, nameInstance: String? = nil) {
        super.init(frame: .zero)
        setupView(bgColor: bgColor, nameInstance: nameInstance)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)
        if let customView = hitView as? CustomView {
            delegate?.sendName(customView.nameInstance ?? "nil")
        }
        return hitView
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if super.point(inside: point, with: event) {
            return true
        }
        for subview in subviews {
            let pointInSubview = subview.convert(point, from: self)
            if subview.point(inside: pointInSubview, with: event) {
                return true
            }
        }
        return false
    }
    
}

//MARK: - Setup View
private extension CustomView {
    func setupView(bgColor: UIColor, nameInstance: String?) {
        backgroundColor = bgColor
        self.nameInstance = nameInstance
    }
}

