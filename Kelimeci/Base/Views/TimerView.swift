//
//  TimerView.swift
//  Kelimeci
//
//  Created by Emel Topaloglu on 5/10/18.
//  Copyright © 2018 Emel Topaloglu. All rights reserved.
//

import UIKit

class TimerView: UIView {
    fileprivate var timerView = UIStackView()
    fileprivate var timerLabel = UILabel()
    fileprivate var timerIcon = UIImageView()
    fileprivate var timer = Timer()
    fileprivate var counter = 0
    
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
        addSubview(timerView)
        timerView.addArrangedSubview(timerIcon)
        timerView.addArrangedSubview(timerLabel)
        
        timerIcon.snp.makeConstraints { (make) in
            make.height.equalTo(13.0)
            make.width.equalTo(13.0)
        }
        
        timerView.snp.makeConstraints { (make) -> Void in
            make.edges.equalToSuperview()
        }
    }
    
    open func style() {
        backgroundColor = .clear
        timerLabel.style(.book12White)
        timerView.spacing = 5.0
        timerView.distribution = .equalCentering
        timerView.alignment = .center
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTimer(with:)), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        timer.invalidate()
        counter = 0
    }
    
    @objc
    fileprivate func updateTimer(with timer: Timer) {
        counter += 1
        let seconds = (counter / 10) % 60
        let minutes = ((counter / 10) / 60)
        let hours = ((counter / 10) / 3600)
        timerLabel.text = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}
