//
//  MainViewController.swift
//  Kelimeci
//
//  Created by Emel Topaloglu on 6/4/18.
//  Copyright © 2018 Emel Topaloglu. All rights reserved.
//

import Foundation
import SnapKit

class MainViewController: ViewController {
    fileprivate var stackView = UIStackView()
    fileprivate var easyLvlButton = GameTypeButton()
    fileprivate var mediumLvlButton = GameTypeButton()
    fileprivate var difficultLvlButton = GameTypeButton()
    fileprivate var randomLvlButton = GameTypeButton()
    fileprivate var infoLabel = UILabel()
    
    struct Constants {
        static let gameSegue = "GameViewController"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        style()
        addButtonActions()
    }
    
    fileprivate func addSubviews() {
        view.addSubview(infoLabel)
        view.addSubview(stackView)
        stackView.addArrangedSubview(easyLvlButton)
        stackView.addArrangedSubview(mediumLvlButton)
        stackView.addArrangedSubview(difficultLvlButton)
        stackView.addArrangedSubview(randomLvlButton)
        stackView.isUserInteractionEnabled = true
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(topLayoutGuide.snp.bottom)
            make.leading.equalToSuperview().offset(30.0)
            make.trailing.equalToSuperview().offset(-30.0)
            make.bottom.equalTo(stackView.snp.top).offset(-20.0)
        }
        
        stackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(50.0)
            make.trailing.equalToSuperview().offset(-50.0)
        }
    }
    
    fileprivate func style() {
//        view.backgroundColor = .kDarkGray
        stackView.axis = .vertical
        stackView.spacing = 20.0
        infoLabel.text = Localized("game_info")
        infoLabel.numberOfLines = 0
        infoLabel.textAlignment = .center
        infoLabel.style(.book13White)
        easyLvlButton.update(forTitle: "Kolay", subtitle: "8-9 Harf 3 dk")
        mediumLvlButton.update(forTitle: "Meh", subtitle: "10-11 Harf 4 dk")
        difficultLvlButton.update(forTitle: "Zor", subtitle: "12-13 Harf 5 dk")
        randomLvlButton.update(forTitle: "Karışık", subtitle: "8-13 Harf 4 dk")
    }
    
    
    fileprivate func addButtonActions() {
        easyLvlButton.addTarget(self, action: #selector(easyLvlSelected), for: .touchUpInside)
        mediumLvlButton.addTarget(self, action: #selector(mediumLvlSelected), for: .touchUpInside)
        difficultLvlButton.addTarget(self, action: #selector(difficultLvlSelected), for: .touchUpInside)
        randomLvlButton.addTarget(self, action: #selector(randomLvlSelected), for: .touchUpInside)
    }
    
    @objc
    func easyLvlSelected() {
        GameSession.shared.difficulty = .easy
        performSegue(withIdentifier: Constants.gameSegue, sender: self)
    }
    
    @objc
    func mediumLvlSelected() {
        GameSession.shared.difficulty = .medium
        performSegue(withIdentifier: Constants.gameSegue, sender: self)
    }
    
    @objc
    func difficultLvlSelected() {
        GameSession.shared.difficulty = .difficult
        performSegue(withIdentifier: Constants.gameSegue, sender: self)
    }
    
    @objc
    func randomLvlSelected() {
        GameSession.shared.difficulty = .random
        performSegue(withIdentifier: Constants.gameSegue, sender: self)
    }
}
