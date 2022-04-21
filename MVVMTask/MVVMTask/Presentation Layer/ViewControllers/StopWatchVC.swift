//
//  ViewController.swift
//  MVVMTask
//
//  Created by Apple User on 21/04/22.
//

import UIKit

class StopWatchVC: UIViewController {
   
    //MARK: - Outlets and Properties
    
    @IBOutlet weak var pauseBtn: UIButton!
    @IBOutlet weak var stopBtn: UIButton!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var alertLbl: UILabel!
    var seconds = 0
    var timer = Timer()
    var isTimerRunning = false
    var resumeTapped = false
    
    //MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pauseBtn.isEnabled = false
    }
    
    //MARK: - Actions
    
    @IBAction func startTimer(_ sender: Any) {
        if isTimerRunning == false {
                  runTimer()
            self.startBtn.isEnabled = false
            alertLbl.text = "RUN!!"
            self.stopBtn.setTitle("Reset", for: .normal)
             }
    }
    
    @IBAction func pauseTimer(_ sender: Any) {
       
             if self.resumeTapped == false {
                  timer.invalidate()
                  self.resumeTapped = true
                 alertLbl.text = "DON'T STOP NOW!!"
                 self.pauseBtn.setTitle("Resume", for: .normal)
             } else {
                  runTimer()
                  self.resumeTapped = false
                 alertLbl.text = "KEEP RUNNING!!"
                 self.pauseBtn.setTitle("Pause", for: .normal)
             }
        }
        
    
    @IBAction func stopTimer(_ sender: Any) {
        timer.invalidate()
        seconds = 0
        alertLbl.text = ""
        timeLbl.text = timeString(time: TimeInterval(seconds))
        self.stopBtn.setTitle("Stop", for: .normal)
        self.startBtn.isEnabled = true
        isTimerRunning = false
        self.pauseBtn.isEnabled = false
        
    }
    
    //MARK: - Functions
    
    func runTimer() {
         timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(StopWatchVC.updateTimer)), userInfo: nil, repeats: true)
        isTimerRunning = true
        self.pauseBtn.isEnabled = true
    }
    
    @objc func updateTimer() {
                  seconds += 1
                 timeLbl.text = timeString(time: TimeInterval(seconds))
             }
       
    
    func timeString(time:TimeInterval) -> String {
    let hours = Int(time) / 3600
    let minutes = Int(time) / 60 % 60
    let seconds = Int(time) % 60
        return String(format: "%02i:%02i:%02i" , hours, minutes, seconds)
    }
}

