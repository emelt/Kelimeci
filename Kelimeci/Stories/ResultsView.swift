//
//  ResultsView.swift
//  Kelimeci
//
//  Created by Emel Topaloglu on 6/4/18.
//  Copyright © 2018 Emel Topaloglu. All rights reserved.
//

import Foundation

protocol ResultsViewDelegate: class {
    func resultsViewDidTapMissedWords(view: ResultsView)
    func resultsViewDidTapNext(view: ResultsView)
}

class ResultsView: UIView {
    fileprivate var backgroundView = UIView()
    fileprivate var cartView = UIView()
    fileprivate var largeStackView = UIStackView()
    fileprivate var noteLabel = UILabel()
    fileprivate var detailLabel = UILabel()
    fileprivate var scoreLabel = UILabel()
    fileprivate let circleLayer = CAShapeLayer()
    fileprivate var buttonsStackView = UIStackView()
    fileprivate var missedWordsButton = UIButton()
    fileprivate var nextButton = UIButton()
    fileprivate var animationView = UIView()
    weak var delegate: ResultsViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        style()
        addButtonActions()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
        style()
        addButtonActions()
    }
    
    open func setupSubviews() {
        addSubview(backgroundView)
        addSubview(cartView)
        cartView.addSubview(largeStackView)
        largeStackView.addArrangedSubview(noteLabel)
        largeStackView.addArrangedSubview(detailLabel)
        largeStackView.addArrangedSubview(scoreLabel)
        largeStackView.addArrangedSubview(animationView)
        largeStackView.addArrangedSubview(buttonsStackView)
        buttonsStackView.addArrangedSubview(missedWordsButton)
        buttonsStackView.addArrangedSubview(nextButton)
        
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        cartView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.85)
            make.height.equalToSuperview().multipliedBy(0.7)
        }
        
        largeStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20.0)
            make.trailing.equalToSuperview().offset(-20.0)
            make.top.equalToSuperview().offset(20.0)
            make.bottom.equalToSuperview().offset(-20.0)
        }
        
        buttonsStackView.snp.makeConstraints { make in
            make.height.equalTo(50.0)
        }
        
        addCircle()
    }
    
    fileprivate func addCircle(){
        animationView.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 50, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        circleLayer.path = circularPath.cgPath
        circleLayer.strokeColor = UIColor.kPink.cgColor
        circleLayer.lineWidth = 10.0
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineCap = kCALineCapRound
        circleLayer.position = animationView.center
        circleLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        circleLayer.strokeEnd = 0
        animationView.layer.addSublayer(circleLayer)
    }
    
    fileprivate func style() {
        backgroundColor = .clear
        
        buttonsStackView.axis = .horizontal
        buttonsStackView.spacing = 20.0
        buttonsStackView.distribution = .fillEqually
        largeStackView.axis = .vertical
        largeStackView.spacing = 30.0
        largeStackView.distribution = .equalCentering
        
        nextButton.layer.cornerRadius = 25.0
        nextButton.backgroundColor = .kPink
        nextButton.setTitle(Localized("next"), for: .normal)
        
        missedWordsButton.layer.cornerRadius = 25.0
        missedWordsButton.layer.borderColor = UIColor.kPink.cgColor
        missedWordsButton.layer.borderWidth = 2.0
        missedWordsButton.setTitle(Localized("missed_words"), for: .normal)
        
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        cartView.backgroundColor = UIColor.kSoftWhite.withAlphaComponent(0.9)
        
        scoreLabel.textAlignment = .center
        scoreLabel.style(.book13Gray)
        noteLabel.textAlignment = .center
        noteLabel.style(.book13Gray)
        detailLabel.textAlignment = .center
        detailLabel.style(.book13Gray)
        scoreLabel.numberOfLines = 0
        noteLabel.numberOfLines = 0
        detailLabel.numberOfLines = 0
    }
    
    fileprivate func addButtonActions() {
        nextButton.addTarget(self, action: #selector(nextButtonTapped(sender:)), for: .touchUpInside)
        missedWordsButton.addTarget(self, action: #selector(missedWordsButtonTapped(sender:)), for: .touchUpInside)
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
        circleLayer.position = animationView.center
    }
    
    func show(animated: Bool, currentScore: Int, maximumAvailableScore: Int, guessedWordCount: Int, totalWordCount: Int, longestWord: String) {
        noteLabel.text = longestWord
        detailLabel.text = "\(totalWordCount) kelimenin \(guessedWordCount) tanesini buldunuz"
        scoreLabel.text = "\(currentScore)"

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
            self.animateCircle(duration: 1.0, score: CGFloat(CGFloat(currentScore) / CGFloat(maximumAvailableScore)))
        })
    }
    
    func hide(animated: Bool) {
        UIView.animate(withDuration: animated ? 0.3 : 0.0, animations: {
            self.alpha = 0.5
            self.layer.transform = CATransform3DMakeScale(0.1, 0.1, 0.1)
        }) { _ in
            self.removeFromSuperview()
        }
    }
    
    @objc func nextButtonTapped(sender: UIButton) {
        delegate?.resultsViewDidTapNext(view: self)
    }
    
    @objc func missedWordsButtonTapped(sender: UIButton) {
        delegate?.resultsViewDidTapMissedWords(view: self)
    }
}
