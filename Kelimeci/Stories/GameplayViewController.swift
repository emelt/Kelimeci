//
//  GameplayViewController.swift
//  Kelimeci
//
//  Created by Emel Topaloglu on 8/24/17.
//  Copyright © 2017 Emel Topaloglu. All rights reserved.
//

import UIKit

class GameplayViewController: ViewController {
    fileprivate var timerView = TimerView()
    fileprivate var hintsView = HintsView()
    fileprivate var matchesView = MatchesView()
    fileprivate var lettersView = LettersView()
    fileprivate var guessView = GuessedWord()
    fileprivate var controlView = ControlPanelView()
    var viewModel = GameplayViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        style()
        loadCharacters()
    }
    
    fileprivate func addSubviews() {
        view.addSubview(timerView)
        view.addSubview(matchesView)
        view.addSubview(hintsView)
        view.addSubview(lettersView)
        view.addSubview(guessView)
        view.addSubview(controlView)
        
        timerView.delegate = self
        timerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30.0)
            make.centerX.equalToSuperview()
            make.width.equalTo(60.0)
            make.height.equalTo(60.0)
        }
        
        hintsView.snp.makeConstraints { make in
            make.top.equalTo(timerView.snp.bottom).offset(10.0)
            make.leading.equalToSuperview().offset(20.0)
            make.trailing.equalToSuperview().offset(-20.0)
            make.height.equalTo(50.0)
        }
        
        matchesView.snp.makeConstraints { make in
            make.top.equalTo(hintsView.snp.bottom).offset(10.0)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.3)
        }
        
        controlView.delegate = self
        controlView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(50.0)
        }
        
        lettersView.delegate = self
        lettersView.isMinimal = viewModel.isMinimal
        lettersView.snp.makeConstraints { make in
            make.bottom.equalTo(controlView.snp.top)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.2)
        }
        
        guessView.snp.makeConstraints { make in
            make.bottom.equalTo(lettersView.snp.top)
            make.top.equalTo(matchesView.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    fileprivate func style() {
        view.backgroundColor = .kGray
    }
    
    fileprivate func loadCharacters() {
        let words = Parser().parseGames(with: "games")
        viewModel.word = words[1]
        hintsView.update(withWord: viewModel.word!)
        matchesView.word = viewModel.word
        lettersView.update(with: (viewModel.word?.characters)!)
        timerView.startTimer(for: 180)
    }
    
    func userDidType(character: String) {
        guessView.append(character: character)
        viewModel.currentCharacters.remove(character)
        viewModel.currentWord = viewModel.currentWord + character
    }
    
    func userDidGuessWord() {
        if viewModel.checkCurrentWord() {
            matchesView.guess(word: viewModel.currentWord)
            userDidReset()
        }
    }
    
    func userDidReset() {
        viewModel.currentWord = ""
        lettersView.update(with: (viewModel.word?.characters)!)
        guessView.clear()
    }
    
    func userDidDeleteCharacter() {
        let character = guessView.removeLast()
        if !character.isEmpty {
            lettersView.add(character: character)
            viewModel.currentWord.removeLast()
        }
    }
    
    func userDidShuffle() {
        lettersView.shuffle()
    }
}

extension GameplayViewController: LettersViewDelegate {
    func tilesViewDidSelectItem(view: LettersView, character: String) {
        userDidType(character: character)
    }
}

extension GameplayViewController: ControlPanelViewDelegate {
    func deleteButtonTapped(view: ControlPanelView) {
        userDidDeleteCharacter()
    }
    
    func guessButtonTapped(view: ControlPanelView) {
        userDidGuessWord()
    }
    
    func resetButtonTapped(view: ControlPanelView) {
        userDidReset()
    }
    
    func shuffleButtonTapped(view: ControlPanelView) {
        userDidShuffle()
    }
}

extension GameplayViewController: TimerViewDelegate {
    func timerViewDidEnd(timerView: TimerView) {
        timerView.stopTimer()
        matchesView.revealAll()
        let resultsView = ResultsView()
        resultsView.show(animated: true)
    }
}
