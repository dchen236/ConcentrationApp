//
//  ViewController.swift
//  Concentration
//
//  Created by Danni on 1/1/19.
//  Copyright © 2019 Danni Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
//    properties
    private let numberOfCardsPerRow = 4
    private let numberOfPairs = 10  //must be a multiple of 2
    var game:Game!
    var identifierToEmojies = [Int:String]()
    
    var score:Int = 0{
        didSet{
            scoreLabel.text = "Score:\(score)"
        }
    }
    
    var flips:Int = 0{
        didSet{
            flipsCountLabel.text = "Flips:\(flips)"
        }
    }
    
    lazy var cardButtons:[UIButton] = {
        var cards = [UIButton]()
        for i in 0..<numberOfPairs{
            let card1 = UIButton()
            card1.backgroundColor = .black
            card1.tag = i*2
            card1.titleLabel?.font = UIFont.systemFont(ofSize: 38)
            card1.addTarget(self, action: #selector(cardTapped), for: .touchUpInside)
            card1.translatesAutoresizingMaskIntoConstraints = false
            let card2 = UIButton()
            card2.tag = i*2+1
            card2.titleLabel?.font = UIFont.systemFont(ofSize: 38)
            card2.backgroundColor = .black
            card2.addTarget(self, action: #selector(cardTapped(sender:)), for: .touchUpInside)
            card2.translatesAutoresizingMaskIntoConstraints = false
            cards+=[card1,card2]
        }
        return cards
    }()
    
    @objc func cardTapped(sender:UIButton){
        flips+=1
        game.cardSelected(selectedCardIndex:sender.tag)
        score = game.newScore()
        updateUI()
    }
    
    private func updateUI(){
        for index in game.cards.indices{
            let card = game.cards[index]
            let cardButton = cardButtons[index]
            if card.isFaceUp{
                let emoji = emojiForIdentifier(identifier:card.identifier)
                cardButton.backgroundColor = .white
                cardButton.setTitle(emoji, for: .normal)
            }
            else{
                cardButton.backgroundColor = .black
                cardButton.setTitle("", for: .normal)
            }
            
            if card.isMatched{
                cardButton.backgroundColor = .clear
                cardButton.setTitle("", for: .normal)
            }

        }
    }
    
    private func emojiForIdentifier(identifier:Int)->String{
        if identifierToEmojies.keys.contains(identifier){
            return identifierToEmojies[identifier]!
        }
        else{
            let randomIndex = Int.random(in:0..<game.emojies.count)
            let randomEmoji = game.emojies[.smileyFace]!.remove(at: randomIndex)
            identifierToEmojies[identifier] = randomEmoji
            return randomEmoji
        }
    }

    let newGameButton:UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(newGamePressed), for: .touchUpInside)
        return button
    }()
    
    @objc func newGamePressed(){
        game = Game(numberOfPairs: numberOfPairs)
        flips = 0
        score = 0
        updateUI()
    }
    
    let flipsCountLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Flips:0"
        label.font = UIFont.boldSystemFont(ofSize: 23)
        return label
    }()
    
    let scoreLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "Score:0"
        label.font = UIFont.boldSystemFont(ofSize: 23)
        label.backgroundColor = .clear
        label.textColor = .black
        return label
    }()
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
//        initialize game
        game = Game(numberOfPairs: numberOfPairs)
    }
    
  
    fileprivate func setUpViews(){
        createStackViewToHoldCards()
        configureNewGameButton()
        configureScoreLabelAndFlipCountLabel()
    }
    fileprivate func configureScoreLabelAndFlipCountLabel() {
        view.addSubview(scoreLabel)
        view.addSubview(flipsCountLabel)
        [flipsCountLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
         flipsCountLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
         flipsCountLabel.widthAnchor.constraint(equalToConstant: 200),
         flipsCountLabel.heightAnchor.constraint(equalToConstant: 30),
         scoreLabel.centerXAnchor.constraint(equalTo: flipsCountLabel.centerXAnchor),
         scoreLabel.bottomAnchor.constraint(equalTo: flipsCountLabel.topAnchor, constant: -10),
         scoreLabel.widthAnchor.constraint(equalTo: flipsCountLabel.widthAnchor),
         scoreLabel.heightAnchor.constraint(equalTo: flipsCountLabel.heightAnchor)].forEach { (constraint) in
            constraint.isActive = true
        }
    }
    
    fileprivate func configureNewGameButton() {
        view.addSubview(newGameButton)
        newGameButton.setTitle("New Game", for: .normal)
        newGameButton.setTitleColor(.black, for: .normal)
        newGameButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        [newGameButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
         newGameButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant:-20),
         newGameButton.heightAnchor.constraint(equalToConstant: 60),
         newGameButton.widthAnchor.constraint(equalToConstant: 100)].forEach { (constraint) in
            constraint.isActive = true
        }
    }
    
   
    
    fileprivate func createStackViewToHoldCards() {
        let bigStackView = UIStackView()
        bigStackView.axis = .vertical
        bigStackView.distribution = .fillEqually
        bigStackView.spacing = 15
        bigStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bigStackView)
//        slice cards
        for i in 0..<cardButtons.count/numberOfCardsPerRow{
            var cardsInRow = [UIButton]()
            for j in 0...3{
                cardsInRow.append(cardButtons[i*4+j])
            }

            let stackView = UIStackView(arrangedSubviews:cardsInRow)
            stackView.distribution = .fillEqually
            stackView.axis = .horizontal
            stackView.spacing = 15
            stackView.translatesAutoresizingMaskIntoConstraints = false
            bigStackView.addArrangedSubview(stackView)
        }
//      anchor bigStackView
        [bigStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant:80),
         bigStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -150),
         bigStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant:20),
         bigStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant:-20)].forEach { (constraint) in
            constraint.isActive = true
        }
    }



}


