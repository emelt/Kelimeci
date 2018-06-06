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
    fileprivate var scoreLabel = UILabel()
    
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
        stackView.addArrangedSubview(scoreLabel)
        
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
        scoreLabel.textAlignment = .center
        scoreLabel.style(.book12White)
        titleLabel.style(.book12White)
        titleLabel.text = Localized("score")
        scoreLabel.text = ""
    }
    
    func animateScoreChange(score: Int) {
        UIView.animate(withDuration: 0.1, animations: {
            self.titleLabel.alpha = 0.0
            self.animationView.alpha = 1.0
        }) { _ in
            self.animationView.animation = "check.json"
            self.animationView.play(completion: { _ in
                UIView.animate(withDuration: 0.1) {
                    self.titleLabel.alpha = 1.0
                    self.animationView.alpha = 0.0
                }
            })
        }
        
        UIViewPropertyAnimator(duration: 0.3, curve: .easeIn) {
            self.scoreLabel.text = "\(score)"
        }.startAnimation()
    }
    
    func animateFail() {
        UIView.animate(withDuration: 0.1, animations: {
            self.titleLabel.alpha = 0.0
            self.animationView.alpha = 1.0
        }) { _ in
            self.animationView.animation = "error.json"
            self.animationView.play(completion: { _ in
                UIView.animate(withDuration: 0.1) {
                    self.titleLabel.alpha = 1.0
                    self.animationView.alpha = 0.0
                }
            })
        }
    }
}
