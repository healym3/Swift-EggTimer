//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    

    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var timerLabel: UILabel!
    var player: AVAudioPlayer!
    
    let eggTimes :[String: Int] = ["Soft": 300, "Medium": 420, "Hard": 720]
    
    var secondsPassed = 0
    var timer = Timer()
    var totalTime = 0
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        progressBar.transform = progressBar.transform.scaledBy(x: 1, y: 10)
        timer.invalidate()
        let hardness = sender.currentTitle!
        timerLabel.text = hardness + " Timer Running..."
        totalTime = eggTimes[hardness]!
        secondsPassed = 0
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    @objc func updateTimer(){
        if (secondsPassed < totalTime){
            let percentageProgressed = Float(secondsPassed)/Float(totalTime)
            progressBar.progress = percentageProgressed
            print("\(secondsPassed) seconds.")
            secondsPassed += 1
        } else {
            progressBar.progress=1.0
            timer.invalidate()
            timerLabel.text = "Done!"
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
                    player = try! AVAudioPlayer(contentsOf: url!)
                    player.play()        }
    }
}
