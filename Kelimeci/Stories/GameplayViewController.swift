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
    fileprivate var scoresView = ScoreView()
    fileprivate var nextButton = UIButton()
    fileprivate var buttonView = UIView()
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
        view.addSubview(scoresView)
        view.addSubview(buttonView)
        buttonView.addSubview(nextButton)
        
        timerView.delegate = self
        timerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30.0)
            make.centerX.equalToSuperview()
            make.width.equalTo(60.0)
            make.height.equalTo(60.0)
        }
        
        scoresView.snp.makeConstraints { make in
            make.centerY.equalTo(timerView.snp.centerY)
            
            make.trailing.equalToSuperview().offset(-30.0)
        }
        
        hintsView.snp.makeConstraints { make in
            make.top.equalTo(timerView.snp.bottom).offset(10.0)
            make.leading.equalToSuperview().offset(20.0)
            make.trailing.equalToSuperview().offset(-20.0)
            make.height.equalTo(100.0)
        }
        
        matchesView.snp.makeConstraints { make in
            make.top.equalTo(hintsView.snp.bottom).offset(10.0)
            make.bottom.equalTo(buttonView.snp.top)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.2)
        }
        
        buttonView.snp.makeConstraints { make in
            make.bottom.equalTo(guessView.snp.top)
            make.leading.equalToSuperview().offset(20.0)
            make.trailing.equalToSuperview().offset(-20.0)
            make.height.equalTo(0.0)
        }
        
        nextButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
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
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(lettersView.snp.top)
        }
    }
    
    fileprivate func style() {
        view.backgroundColor = .kGray
        nextButton.setTitle(Localized("next"), for: .normal)
        nextButton.layer.cornerRadius = 25.0
        nextButton.backgroundColor = .kPink
        
        buttonView.clipsToBounds = true
        lettersView.clipsToBounds = true
        guessView.clipsToBounds = true
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    fileprivate func loadCharacters() {
        if let word = GameSession.shared.nextWord {
            viewModel.word = word
            hintsView.update(withWord: viewModel.word!)
            matchesView.word = viewModel.word
            lettersView.update(with: (viewModel.word?.characters)!)
            timerView.startTimer(for: GameSession.shared.time)
            
            hintsView.snp.updateConstraints { make in
                make.height.equalTo(hintsView.maximumHeight)
            }
        }
    }
    
    func userDidType(character: String) {
        guessView.append(character: character)
        viewModel.currentCharacters.remove(character)
        viewModel.currentWord = viewModel.currentWord + character
    }
    
    func userDidGuessWord() {
        if viewModel.guessCurrentWord() {
            matchesView.guess(word: viewModel.currentWord)
            scoresView.animateScoreChange(score: viewModel.score)
            hintsView.userDidGuess(word: viewModel.currentWord)
            userDidReset()
        } else {
            scoresView.animateFail()
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
    
    func transitionToResults() {
        controlView.snp.updateConstraints { make in
            make.height.equalTo(0.0)
        }
        
        lettersView.snp.remakeConstraints { make in
            make.bottom.equalTo(controlView.snp.top)
            make.top.equalTo(guessView.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(0.0)
        }
        
        buttonView.snp.updateConstraints { make in
            make.height.equalTo(50.0)
            make.bottom.equalTo(guessView.snp.top).offset(-20.0)
        }

        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    func nextGame() {
        guard let word = viewModel.word else { return }
        
        GameSession.shared.finishWord(word: word)
        if let newGameViewController = GameplayViewController.instanceFromStoryboard(name: "Main") {
            navigationController?.pushViewController(newGameViewController, animated: true)
        }
    }
    
    @objc func nextButtonTapped() {
        nextGame()
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
        
        guard let word = viewModel.word else { return }
        GameSession.shared.finishWord(word: word)
        
        guessView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(lettersView.snp.top)
            make.top.equalTo(buttonView.snp.bottom)
            make.height.equalTo(0.0)
        }
        
        matchesView.snp.remakeConstraints { make in
            make.top.equalTo(hintsView.snp.bottom).offset(10.0)
            make.bottom.equalTo(buttonView.snp.top)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        
        let resultsView = ResultsView()
        resultsView.delegate = self
        resultsView.show(animated: true, currentScore: viewModel.score, maximumAvailableScore: viewModel.getMaximumScore(), guessedWordCount: viewModel.guessedWords.count, totalWordCount: viewModel.word?.allWords.count ?? 0, longestWord: viewModel.getLongestWord())
    }
}

extension GameplayViewController: ResultsViewDelegate {
    func resultsViewDidTapMissedWords(view: ResultsView) {
        //todo switch view state to something else
        view.hide(animated: true)
        transitionToResults()
    }
    
    func resultsViewDidTapNext(view: ResultsView) {
        view.hide(animated: true)
        nextGame()
    }
}
