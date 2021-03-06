//
//  ViewController.swift
//  GamingWindow
//
//  Created by p-x9 on 2021/07/06.
//  
//

import UIKit
import NotchCorners

class ViewController: UIViewController {

    let shapeLayer = CAShapeLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .black

        // shapeLayer.path = self.createPath().cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.strokeStart = 0.0
        shapeLayer.strokeEnd = 0.0
        shapeLayer.lineWidth = 8.0
        view.layer.addSublayer(shapeLayer)

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = UIColor.rainbow()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        gradientLayer.startPoint = CGPoint.zero
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.mask = shapeLayer
        view.layer.addSublayer(gradientLayer)

        let tapGR = UITapGestureRecognizer(target: self, action: #selector(animate))
        self.view.addGestureRecognizer(tapGR)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        shapeLayer.path = self.createPath().cgPath
    }

    @objc
    func animate() {
        let animation1 = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
        animation1.fromValue         = 0.0
        animation1.toValue           = 1.0
        animation1.duration          = 1.0

        animation1.beginTime = 0

        animation1.isRemovedOnCompletion = false
        animation1.fillMode = .forwards

        let animation2 = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeStart))
        animation2.fromValue         = 0.0
        animation2.toValue           = 1.0
        animation2.duration          = 1.0
        animation2.beginTime = 1/*+CACurrentMediaTime()*/

        let group = CAAnimationGroup()
        group.duration = 2.0
        group.repeatCount = .infinity
        group.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        group.animations = [animation1, animation2]

        self.shapeLayer.add(group, forKey: "group-animation")
    }

    // ref:https://stackoverflow.com/questions/65283017/how-do-you-trace-the-border-of-an-iphone-screen-including-the-notch-for-an-x-1
    func createPath() -> UIBezierPath {
        let devicePointWidth = UIScreen.main.bounds.size.width
        let devicePointHeight = UIScreen.main.bounds.size.height

        let circleTop = CGFloat(3 * Double.pi / 2)
        let circleRight = CGFloat(0)
        let circleBottom = CGFloat(Double.pi / 2)
        let circleLeft = CGFloat(Double.pi)

        let cornerRadius = UIScreen.main.displayCornerRadius
        let notchTopCornerRadius = UIScreen.main.notchTopCornerRadius
        let notchBottomCornerRadius = UIScreen.main.notchBottomCornerRadius
        let notchSize = UIScreen.main.notchSize

        let w = (devicePointWidth - notchSize.width) / 2// cornerRadius*2+notchTopCornerRadius
        let n = notchSize.width

        let framePath = UIBezierPath()
        // move to (0,0).
        framePath.move(to: CGPoint(x: cornerRadius, y: 0))
        // Line to the right.
        framePath.addLine(to: CGPoint(x: w - notchTopCornerRadius, y: 0))
        // Notch top corner
        framePath.addArc(withCenter: CGPoint(x: w - notchTopCornerRadius, y: notchTopCornerRadius),
                         radius: notchTopCornerRadius,
                         startAngle: circleTop, endAngle: circleRight,
                         clockwise: true)
        // Notch bottom corner
        framePath.addArc(withCenter: CGPoint(x: w + notchBottomCornerRadius, y: notchSize.height - notchBottomCornerRadius),
                         radius: notchBottomCornerRadius,
                         startAngle: circleLeft, endAngle: circleBottom,
                         clockwise: false)
        // Line to the right.
        framePath.addLine(to: CGPoint(x: w + n - notchBottomCornerRadius, y: notchSize.height))
        // Notch bottom corner
        framePath.addArc(withCenter: CGPoint(x: w + n - notchBottomCornerRadius, y: notchSize.height - notchBottomCornerRadius),
                         radius: notchBottomCornerRadius,
                         startAngle: circleBottom, endAngle: circleRight,
                         clockwise: false)
        // Notch top corner
        framePath.addArc(withCenter: CGPoint(x: w + n + notchTopCornerRadius, y: notchTopCornerRadius),
                         radius: notchTopCornerRadius,
                         startAngle: circleLeft, endAngle: circleTop,
                         clockwise: true)
        // Line upward.
        framePath.addLine(to: CGPoint(x: devicePointWidth - cornerRadius, y: 0))
        // Display's top right corner
        framePath.addArc(withCenter: CGPoint(x: devicePointWidth - cornerRadius, y: cornerRadius),
                         radius: cornerRadius,
                         startAngle: circleTop, endAngle: circleRight,
                         clockwise: true)
        // Line downward
        framePath.addLine(to: CGPoint(x: devicePointWidth, y: devicePointHeight - cornerRadius))
        // Display's bottom right corner
        framePath.addArc(withCenter: CGPoint(x: devicePointWidth - cornerRadius, y: devicePointHeight - cornerRadius),
                         radius: cornerRadius,
                         startAngle: circleRight, endAngle: circleBottom,
                         clockwise: true)
        // Line to the left.
        framePath.addLine(to: CGPoint(x: cornerRadius, y: devicePointHeight))
        // Display's bottom left corner
        framePath.addArc(withCenter: CGPoint(x: cornerRadius, y: devicePointHeight - cornerRadius),
                         radius: cornerRadius,
                         startAngle: circleBottom, endAngle: circleLeft,
                         clockwise: true)
        // Line upward.
        framePath.addLine(to: CGPoint(x: 0, y: cornerRadius))
        // Display's top left corner
        framePath.addArc(withCenter: CGPoint(x: cornerRadius, y: cornerRadius),
                         radius: cornerRadius,
                         startAngle: circleLeft, endAngle: circleTop,
                         clockwise: true)

        return framePath
    }
}
