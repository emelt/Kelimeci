//
//  ScoreView.swift
//  Kelimeci
//
//  Created by Emel Topaloglu on 6/6/18.
//  Copyright © 2018 Emel Topaloglu. All rights reserved.
//

import Foundation
import Lottie

class ScoreView: UIView {
    fileprivate var titleLabel = UILabel()
    fileprivate var stackView = UIStackView()
    fileprivate var animationView = LOTAnimationView()
    
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
        addSubview(stackView)
        stackView.addSubview(titleLabel)
        stackView.addArrangedSubview(animationView)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        animationView.snp.makeConstraints { make in
            make.width.equalTo(30.0)
            make.height.equalTo(30.0)
        }
    
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(animationView.snp.centerY)
            make.centerX.equalTo(animationView.snp.centerX)
        }
    }
    
    open func style() {
        backgroundColor = .clear
        stackView.axis = .vertical
        stackView.spacing = 10.0
        titleLabel.textAlignment = .center
        titleLabel.style(.book12White)
        titleLabel.text = Localized("score") + "0"
    }
    
    func animateScoreChange(score: Int) {
        UIView.animate(withDuration: 0.1, animations: {
            self.titleLabel.alpha = 0.0
            self.animationView.alpha = 1.0
        }) { _ in
            self.animationView.animation = "check.json"
            self.animationView.play(fromProgress: 0.3, toProgress: 0.8, withCompletion: { _ in
                UIView.animate(withDuration: 0.1) {
                    self.titleLabel.alpha = 1.0
                    self.animationView.alpha = 0.0
                    self.titleLabel.text = Localized("score") + "\(score)"
                }
            })
        }
    }
    
    func animateFail() {
        UIView.animate(withDuration: 0.1, animations: {
            self.titleLabel.alpha = 0.0
            self.animationView.alpha = 1.0
        }) { _ in
            self.animationView.animation = "error.json"
            self.animationView.play(fromProgress: 0.3, toProgress: 0.7, withCompletion: { _ in
                UIView.animate(withDuration: 0.1) {
                    self.titleLabel.alpha = 1.0
                    self.animationView.alpha = 0.0
                }
            })
        }
    }
}
