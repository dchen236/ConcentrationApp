//
//  PromotionController.swift
//  Concentration
//
//  Created by Danni on 1/1/19.
//  Copyright © 2019 Danni Chen. All rights reserved.
//

import UIKit

class PromotionController: UIViewController {
   
    var numberofPair:Int?{
        didSet{
            if theme != nil{
                newGameButton.isHidden = false
            }
        }
    }
    var theme:Theme?{
        didSet{
            if numberofPair != nil{
                newGameButton.isHidden = false
            }
        }
    }
    
    let themesDict:[String:Theme] = ["Animal":.animal,"Smiley Face":.smileyFace,"Wheather":.wheather,"Fruit":.fruit,"Flag":.flag]
    
    lazy var themeButtons:[UIButton] = {
        var buttons = [UIButton]()
        let themeHeaderButton = UIButton().createButtonWithTitle(title:"Themes")
        themeHeaderButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        buttons.append(themeHeaderButton)
        for i in 0..<themesDict.keys.count{
            let keys = Array(themesDict.keys)
            let button = UIButton().createButtonWithTitle(title: keys[i])
            button.addTarget(self, action: #selector(buttonSelected(sender:)), for: .touchUpInside)
            buttons.append(button)
        }
        return buttons

    }()
    @objc private func buttonSelected(sender:UIButton){
        sender.layer.borderWidth = 5
        sender.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        switch sender.titleLabel?.text {
        case "Animal":
            theme = .animal
        case "Smiley Face":
            theme = .smileyFace
        case "Wheather":
            theme = .wheather
        case "Fruit":
            theme = .fruit
        case "Flag":
            theme = .flag
        case "\(8) pairs":
            numberofPair = 8
        case "\(10) pairs":
            numberofPair = 10
        case "\(12) pairs":
            numberofPair = 12
        default:
            break
        }
    }
    
    lazy var numberOfPairsButtons:[UIButton] = {
        var buttons = [UIButton]()
        let pairsNumberButton = UIButton().createButtonWithTitle(title: "Number of pairs")
        pairsNumberButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        buttons.append(pairsNumberButton)
        for i in 2...3{
            let button = UIButton().createButtonWithTitle(title: "\(i*4) pairs")
            button.addTarget(self, action: #selector(buttonSelected(sender:)), for: .touchUpInside)
            buttons.append(button)
        }
        return buttons
    }()
  
    
    
    let newGameButton:UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Start", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5
        button.layer.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        button.layer.borderWidth = 3
        button.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(newGame), for:.touchUpInside )
        return button
    }()
    
    @objc fileprivate func newGame(){
        print("New game pressed")
        print("\(numberofPair!)")
        print("\(theme!)")
    }
    
    fileprivate func setUpLabels() {
        let themeStackView = UIStackView(arrangedSubviews: themeButtons)
        view.addSubview(themeStackView)
        themeStackView.axis = .vertical
        themeStackView.alignment = .fill
        themeStackView.distribution = .fillEqually
        themeStackView.spacing = 5
        themeStackView.translatesAutoresizingMaskIntoConstraints = false
        themeStackView.constraintWithAnchors(centerXAnchor: view.safeAreaLayoutGuide.centerXAnchor, topAnchor: view.safeAreaLayoutGuide.topAnchor, bottomAnchor: nil, widthAnchorConstant: 200, heightAnchor: view.safeAreaLayoutGuide.heightAnchor, constantToView: 10, multiplier: 0.5)
        
        let pairNumberStack = UIStackView(arrangedSubviews: numberOfPairsButtons)
        pairNumberStack.translatesAutoresizingMaskIntoConstraints = false
        pairNumberStack.axis = .vertical
        pairNumberStack.alignment = .fill
        pairNumberStack.distribution = .fillEqually
        pairNumberStack.spacing = 5
        view.addSubview(pairNumberStack)
        pairNumberStack.constraintWithAnchors(centerXAnchor: view.safeAreaLayoutGuide.centerXAnchor, topAnchor: themeStackView.bottomAnchor, bottomAnchor: nil, widthAnchorConstant: 200, heightAnchor: view.safeAreaLayoutGuide.heightAnchor, constantToView: 10, multiplier: 1/3)
    }
    
    fileprivate func setUpNewGameButton() {
        view.addSubview(newGameButton)
        [newGameButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant:-5),
         newGameButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
         newGameButton.widthAnchor.constraint(equalToConstant: 80),
         newGameButton.heightAnchor.constraint(equalToConstant: 70)].forEach { (constraint) in
            constraint.isActive = true
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpLabels()
        setUpNewGameButton()

    }
    

    

}

extension UIButton{
    func createButtonWithTitle(title:String)->UIButton{
        let button = UIButton()
        button.showsTouchWhenHighlighted = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.black, for: .normal)
        button.setTitle(title, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        return button
    }
    
}


extension UIView{
    func constraintWithAnchors(centerXAnchor:NSLayoutXAxisAnchor,topAnchor:NSLayoutYAxisAnchor?,
                               bottomAnchor:NSLayoutYAxisAnchor?,widthAnchorConstant:CGFloat,
                               heightAnchor:NSLayoutDimension,constantToView:CGFloat?,multiplier:CGFloat){
        self.centerXAnchor.constraint(equalTo:centerXAnchor).isActive = true
        self.widthAnchor.constraint(equalToConstant: widthAnchorConstant).isActive = true
        self.heightAnchor.constraint(equalTo: heightAnchor, multiplier: multiplier).isActive = true
        if let topAnchor = topAnchor {
            if let constant = constantToView {
                self.topAnchor.constraint(equalTo:topAnchor, constant: constant).isActive = true
            }
            else{
                self.topAnchor.constraint(equalTo:topAnchor).isActive = true
            }
        }
        else{
            if let constant = constantToView{
                self.bottomAnchor.constraint(equalTo:bottomAnchor!, constant: constant).isActive = true
            }
            else{
                self.bottomAnchor.constraint(equalTo:bottomAnchor!).isActive = true
            }
        }
       
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}
