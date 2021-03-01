//
//  ViewController.swift
//  eggtimer1
//
//  Created by Aarish Rahman on 28/02/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    let eggTimes = ["soft": 300, "medium": 420, "hard": 720]
    var counter = 60
    var timer = Timer()
    

    @IBAction func eggButton(_ sender: UIButton) {
        timer.invalidate()
        let hardness = sender.currentTitle!
        counter = eggTimes[hardness]!
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    @objc func updateCounter() {
        //example functionality
        if counter > 0 {
            print("\(counter) seconds to the end of the world")
            counter -= 1
        }
    }
    
}

