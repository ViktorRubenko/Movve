//
//  GradientView.swift
//  Movve
//
//  Created by Victor Rubenko on 31.05.2022.
//

import UIKit

class GradientView: UIView {
    
    private let gradient: CAGradientLayer = CAGradientLayer()
    private let gradientStartColor: UIColor
    private let gradientEndColor: UIColor
    private let gradientStartPoint: CGPoint
    private let gradientEndPoint: CGPoint
    
    init(
        gradientStartColor: UIColor,
        gradientEndColor: UIColor,
        gradientStartPoint: CGPoint,
        gradientEndPoint: CGPoint
    ) {
        self.gradientStartColor = gradientStartColor
        self.gradientEndColor = gradientEndColor
        self.gradientStartPoint = gradientStartPoint
        self.gradientEndPoint = gradientEndPoint
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        gradient.frame = self.bounds
    }
    
    override func draw(_ rect: CGRect) {
        gradient.frame = self.bounds
        gradient.colors = [gradientStartColor.cgColor, gradientEndColor.cgColor, gradientEndColor.cgColor]
        gradient.startPoint = gradientStartPoint
        gradient.endPoint = gradientEndPoint
        
        if gradient.superlayer == nil {
            layer.insertSublayer(gradient, at: 0)
        }
    }
}
