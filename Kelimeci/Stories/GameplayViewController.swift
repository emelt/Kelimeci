//
//  GameplayViewController.swift
//  Kelimeci
//
//  Created by Emel Topaloglu on 8/24/17.
//  Copyright © 2017 Emel Topaloglu. All rights reserved.
//

import UIKit

class GameplayViewController: ViewController {
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
        view.addSubview(matchesView)
        view.addSubview(lettersView)
        view.addSubview(guessView)
        view.addSubview(controlView)
        
        matchesView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.4)
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
        viewModel.word = words.first
        matchesView.word = viewModel.word
        lettersView.update(with: (viewModel.word?.characters)!)
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
