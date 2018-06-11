//
//  HintsView.swift
//  Kelimeci
//
//  Created by Emel Topaloglu on 6/4/18.
//  Copyright © 2018 Emel Topaloglu. All rights reserved.
//

import Foundation

protocol HintsViewDelegate: class {
    func hintsViewDidChangeContentSize(hintsView: HintsView, newSize: CGSize)
}

class HintsView: UIView {
    fileprivate lazy var collectionView: UICollectionView = {
        var flowLayout = KTCenterFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 10.0
        flowLayout.sectionInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: flowLayout)
        collectionView.register(HintCell.self, forCellWithReuseIdentifier: HintCell.reuseIdentifier)
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    fileprivate var backgroundImageView = UIImageView()
    fileprivate var stackView = UIStackView()
    fileprivate var word: Word?
    fileprivate var guessedWords = Word()
    fileprivate var existingWordIndexes: [Int] = []
    weak var delegate: HintsViewDelegate?
    
    deinit {
        collectionView.removeObserver(self, forKeyPath: "contentSize")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        style()
        addObserver()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
        style()
        addObserver()
    }
    
    fileprivate func setupSubviews() {
        addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    fileprivate func style() {
        backgroundColor = .clear
        collectionView.backgroundColor = .clear
    }
    
    fileprivate func addObserver() {
        collectionView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    
    func update(withWord word: Word) {
        self.word = word
        guessedWords = Word()
        guessedWords.characters = []
        existingWordIndexes = []
        
        if word.thirteenLetters.count != 0 {
            existingWordIndexes.append(13)
        }
        
        if word.twelveLetters.count != 0 {
            existingWordIndexes.append(12)
        }
        
        if word.elevenLetters.count != 0 {
            existingWordIndexes.append(11)
        }
        
        if word.tenLetters.count != 0 {
            existingWordIndexes.append(10)
        }
        
        if word.nineLetters.count != 0 {
            existingWordIndexes.append(9)
        }
        
        if word.eightLetters.count != 0 {
            existingWordIndexes.append(8)
        }
        
        if word.sevenLetters.count != 0 {
            existingWordIndexes.append(7)
        }
        
        if word.sixLetters.count != 0 {
            existingWordIndexes.append(6)
        }
        
        if word.fiveLetters.count != 0 {
            existingWordIndexes.append(5)
        }
        
        if word.fourLetters.count != 0 {
            existingWordIndexes.append(4)
        }
    }
    
    func userDidGuess(word: String) {
        if word.count == 13 {
            guessedWords.thirteenLetters.append(word)
        }
        if word.count == 12 {
            guessedWords.twelveLetters.append(word)
        }
        if word.count == 11 {
            guessedWords.elevenLetters.append(word)
        }
        if word.count == 10 {
            guessedWords.tenLetters.append(word)
        }
        if word.count == 9 {
            guessedWords.nineLetters.append(word)
        }
        if word.count == 8 {
            guessedWords.eightLetters.append(word)
        }
        if word.count == 7 {
            guessedWords.sevenLetters.append(word)
        }
        if word.count == 6 {
            guessedWords.sixLetters.append(word)
        }
        if word.count == 5 {
            guessedWords.fiveLetters.append(word)
        }
        if word.count == 4 {
            guessedWords.fourLetters.append(word)
        }
        if let wordIndex = existingWordIndexes.index(of: word.count) {
            let indexPath = IndexPath(row: wordIndex, section: 0)
            collectionView.reloadItems(at: [indexPath])
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize" {
            delegate?.hintsViewDidChangeContentSize(hintsView: self, newSize: collectionView.contentSize)
        }
    }
}


// MARK: - UICollectionViewDataSource
extension HintsView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return existingWordIndexes.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HintCell.reuseIdentifier, for: indexPath) as? HintCell {
            guard let word = word else { return cell }
            let characterCount = existingWordIndexes[indexPath.row]
            
            switch characterCount {
            case 13:
                cell.update(withWords: word.thirteenLetters, guessedWords: guessedWords.thirteenLetters)
            case 12:
                cell.update(withWords: word.twelveLetters, guessedWords: guessedWords.twelveLetters)
            case 11:
                cell.update(withWords: word.elevenLetters, guessedWords: guessedWords.elevenLetters)
            case 10:
                cell.update(withWords: word.tenLetters, guessedWords: guessedWords.tenLetters)
            case 9:
                cell.update(withWords: word.nineLetters, guessedWords: guessedWords.nineLetters)
            case 8:
                cell.update(withWords: word.eightLetters, guessedWords: guessedWords.eightLetters)
            case 7:
                cell.update(withWords: word.sevenLetters, guessedWords: guessedWords.sevenLetters)
            case 6:
                cell.update(withWords: word.sixLetters, guessedWords: guessedWords.sixLetters)
            case 5:
                cell.update(withWords: word.fiveLetters, guessedWords: guessedWords.fiveLetters)
            case 4:
                cell.update(withWords: word.fourLetters, guessedWords: guessedWords.fourLetters)
            default:
                return cell
            }
            
            return cell
        }
        return UICollectionViewCell()
    }
}

extension HintsView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (frame.size.width - 40.0) / 4
        let height: CGFloat = 30.0
        return CGSize(width: width, height: height)
    }
}
