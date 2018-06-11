//
//  TimerView.swift
//  Kelimeci
//
//  Created by Emel Topaloglu on 5/10/18.
//  Copyright © 2018 Emel Topaloglu. All rights reserved.
//

import UIKit

protocol TimerViewDelegate: class {
    func timerViewDidEnd(timerView: TimerView)
}

class TimerView: UIView {
    fileprivate var timerLabel = UILabel()
    fileprivate var timer = Timer()
    fileprivate var counter = 0
    fileprivate var originalTime = 0
    fileprivate let progressLayer = CAShapeLayer()
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
        addSubview(timerLabel)
        
        timerLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 30, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        progressLayer.path = circularPath.cgPath
        progressLayer.strokeColor = UIColor.kPink.cgColor
        progressLayer.lineWidth = 5.0
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = kCALineCapRound
        progressLayer.position = timerLabel.center
        progressLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        progressLayer.strokeEnd = 0
        layer.addSublayer(progressLayer)
    }
    
    open func style() {
        backgroundColor = .clear
        timerLabel.textAlignment = .center
        timerLabel.style(.book12White)
    }
    
    func startTimer(for seconds: Int) {
        counter = seconds
        originalTime = seconds
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer(with:)), userInfo: nil, repeats: true)
        updateUI()
    }
    
    func stopTimer() {
        timer.invalidate()
        counter = 0
    }
    
    @objc
    fileprivate func updateTimer(with timer: Timer) {
        counter -= 1
        updateUI()
        
        if counter == 0 {
            delegate?.timerViewDidEnd(timerView: self)
        }
    }
    
    func updateUI() {
        let seconds = (counter) % 60
        let minutes = ((counter) / 60)
        timerLabel.text = String(format: "%02d:%02d", minutes, seconds)
        let percentage = 1 - (CGFloat(counter) / CGFloat(originalTime))
        progressLayer.strokeEnd = percentage
        if percentage > 0.80 {
            progressLayer.strokeColor = UIColor.blend(colors: [UIColor(cgColor: progressLayer.strokeColor!), UIColor.kRed]).cgColor
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        progressLayer.position = timerLabel.center
    }
}
