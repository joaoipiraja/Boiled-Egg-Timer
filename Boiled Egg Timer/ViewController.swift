//
//  ViewController.swift
//  Boiled Egg Timer
//
//  Created by João Victor Ipirajá de Alencar on 20/12/20.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var soft: UIButton!
    @IBOutlet weak var hard: UIButton!
    @IBOutlet weak var medium: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var timeLabel: UILabel!
    
    var secondsRemaining:Float = 60.0
    var timer = Timer()
    
    func showTime(interval: Float) -> String{
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional

        let formattedString = formatter.string(from: TimeInterval(interval))!
        return formattedString
    }
    
    func message(){
        let alert = UIAlertController(title: "Hey", message: "Your egg is ready!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: {_ in }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func updateTimer(sender:Timer){
        
        if(secondsRemaining > 0.0){
    
            if let userInfo = sender.userInfo as? Dictionary<String,Float> {
            
            
                let totalSeconds = Float(userInfo["totalSeconds"] ?? 0.0)

                let percentageProgress =  (100*secondsRemaining/totalSeconds).rounded()/100 //round to 2 decimals places
            
                progressBar.setProgress(percentageProgress, animated: true)
                
                secondsRemaining -= 1.0
                timeLabel.text = showTime(interval: secondsRemaining)
                
            }
        }else{
            message()
        }
    }
    
    func startTimer(totalMinutes:Float){
        
        timer.invalidate()
        secondsRemaining = 60.0*totalMinutes
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: ["totalSeconds":secondsRemaining], repeats: true)
        
    }
    
   
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        switch(sender){
        case soft:
            startTimer(totalMinutes:4.0)
            break
        case medium:
            startTimer(totalMinutes:5.0)
            break
        case hard:
            startTimer(totalMinutes:8.0)
            break
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}

