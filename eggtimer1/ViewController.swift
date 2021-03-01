//
//  ViewController.swift
//  eggtimer1
//
//  Created by Aarish Rahman on 28/02/21.
//

import UIKit

import AVFoundation

var player: AVAudioPlayer?


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    let eggTimes = ["soft": 300, "medium": 420, "hard": 720]
    var totalTime = 0
    var timePassed = 0
    var timer = Timer()
    
    
    @IBOutlet var topLabel: UILabel!//top label IBOutlet
    
    
    @IBAction func eggButton(_ sender: UIButton) {
        
        timer.invalidate() //used to restart the timer
        progressBar.progress = 0.0
        timePassed = 0
        
        let hardness = sender.currentTitle! //sends title to constant hardness
        topLabel.text = hardness // changes top lable to button name
        totalTime = eggTimes[hardness]!
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)/*used to create time interval of 1 second*/
        
    }
    
    
    
    @IBOutlet var progressBar: UIProgressView!
    
    @objc func updateCounter() { //updates counter used in scheduledTimer it uses objective c so for that we need to add @objc
        
        
        if timePassed <= totalTime{
            
            let percentageProgressed = Float(timePassed)/Float(totalTime)  /*calculates progress each no. individually should be converted to float other wise it will give Int value*/
            progressBar.progress = percentageProgressed
            timePassed += 1
            
            
        }else{ // restarts the timer and changes top lable to finished also plays the shitty  alarm sound
            timer.invalidate()
            topLabel.text = "Finished"
            playSound()
        }
    }
    
}


func playSound() { //this function was copied from stackoverflow to play sound
    guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }
    
    do {
        try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
        try AVAudioSession.sharedInstance().setActive(true)
        
        /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
        player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
        
        /* iOS 10 and earlier require the following line:
         player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
        
        guard let player = player else { return }
        
        player.play()
        
    } catch let error {
        print(error.localizedDescription)
    }
}

