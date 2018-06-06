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
    fileprivate var animationView = UIView()
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
        animationView.addSubview(titleLabel)
        stackView.addArrangedSubview(animationView)
        stackView.addArrangedSubview(scoreLabel)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        animationView.snp.makeConstraints { make in
            make.width.equalTo(60.0)
            make.height.equalTo(60.0)
        }
    
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    open func style() {
        backgroundColor = .clear
        scoreLabel.textAlignment = .center
        scoreLabel.style(.book12White)
    }
}
