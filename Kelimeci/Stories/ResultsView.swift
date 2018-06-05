//
//  ResultsView.swift
//  Kelimeci
//
//  Created by Emel Topaloglu on 6/4/18.
//  Copyright © 2018 Emel Topaloglu. All rights reserved.
//

import Foundation

class ResultsView: UIView {
    fileprivate var backgroundView = UIView()
    fileprivate var cartView = UIView()
    fileprivate var scoreLabel = UILabel()
    fileprivate let circleLayer = CAShapeLayer()
    fileprivate let wordsView = MatchesView()
    weak var delegate: TimerViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        style()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
        style()
    }
    
    open func setupSubviews() {
        addSubview(backgroundView)
        addSubview(cartView)
        addSubview(scoreLabel)
        
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        cartView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.85)
            make.height.equalToSuperview().multipliedBy(0.7)
        }
        
        scoreLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 50, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        circleLayer.path = circularPath.cgPath
        circleLayer.strokeColor = UIColor.kPink.cgColor
        circleLayer.lineWidth = 10.0
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineCap = kCALineCapRound
        circleLayer.position = center
        circleLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        circleLayer.strokeEnd = 0
        layer.addSublayer(circleLayer)
    }
    
    open func style() {
        backgroundColor = .clear
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        cartView.backgroundColor = UIColor.kSoftWhite.withAlphaComponent(0.9)
        scoreLabel.textAlignment = .center
        scoreLabel.style(.book12White)
    }
    
    func animateCircle(duration: TimeInterval, score: CGFloat) {
        // We want to animate the strokeEnd property of the circleLayer
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        
        // Set the animation duration appropriately
        animation.duration = duration
        
        // Animate from 0 (no circle) to 1 (full circle)
        animation.fromValue = 0
        animation.toValue = score
        
        // Do a linear animation (i.e. the speed of the animation stays the same)
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        // Set the circleLayer's strokeEnd property to 1.0 now so that it's the
        // right value when the animation ends.
        circleLayer.strokeEnd = score
        
        // Do the actual animation
        circleLayer.add(animation, forKey: "animateCircle")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        circleLayer.position = center
    }
    
    func show(animated: Bool) {
        alpha = 0.5
        layer.transform = CATransform3DMakeScale(0.1, 0.1, 0.1)
        UIApplication.shared.keyWindow?.addSubview(self)
        
        backgroundColor = UIColor.clear
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        UIView.animate(withDuration: animated ? 0.3 : 0.0, animations: {() in
            self.alpha = 1.0
            self.layer.transform = CATransform3DMakeScale(1.0, 1.0, 1.0)
        }, completion: { (_: Bool) in
            self.animateCircle(duration: 1.0, score: 0.8)
        })
    }
    
    func hide(animated: Bool) {
        UIView.animate(withDuration: animated ? 0.3 : 0.0, animations: {
            self.alpha = 0.0
        }) { _ in
            self.removeFromSuperview()
        }
    }
}
