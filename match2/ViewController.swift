//
//  ViewController.swift
//  match2
//
//  Created by Артём Сальников on 01.08.2024.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var stepCount: UILabel!

    var imageNames = ["Merey1","Nuradil",
    "Alina", "Nuradil",
    "Artyom","Merey1",
    "Alina","Dimash",
    "Artyom","Damir",
    "Damir","Alya",
    "Alya","Merey2",
    "Dimash","Merey2"]
    
    var isOpened = false
    var previosButtonTag = 0
    var isTimerEnabled = false
    var count = 0
    
    var steps = 0 {
        didSet {
            stepCount.text = "Количество попыток: " + String(steps)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        stepCount.text = "Нажмите любую кнопку для начала игры"
    }
    
    func clear() {
        
        imageNames.shuffle()
        
        steps = 0
        count = 0
        
        for i in 1...16 {
            
            let button = view.viewWithTag(i) as! UIButton
            
            button.setBackgroundImage(UIImage(named: "empty"), for: .normal)
        }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Вы нашли всех шалунишек MobyDev, молодец", message: "Хотите сыграть снова ?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Конечно", style: .default, handler:{ _ in self.clear()
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
  
    @IBAction func game(_ sender: UIButton) {
        
        if isTimerEnabled == true {
            return
        }
        
        sender.setBackgroundImage(UIImage(named: imageNames[sender.tag - 1]), for: .normal)
        
        if isOpened == true {
            steps += 1
            
            if imageNames[sender.tag - 1] == imageNames[previosButtonTag - 1] {
                count += 1
            } else {
                isTimerEnabled = true
                
                Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in sender.setBackgroundImage(UIImage(named: "empty"), for: .normal)
                    
                    let previousButton = self.view.viewWithTag(self.previosButtonTag) as! UIButton
                    
                    previousButton.setBackgroundImage(UIImage(named: "empty"), for: .normal)
                    
                    self.isTimerEnabled = false
                }
            }
            
        } else {
            previosButtonTag = sender.tag
        }
        
        isOpened.toggle()
        
        if count == 8 {
            showAlert()
        }
    }
    
}

