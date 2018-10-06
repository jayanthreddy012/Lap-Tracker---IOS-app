//
//  ViewController.swift
//  MW1_bujula_jayanthreddy
//
//  Created by Jayanth Bujula on 9/29/18.
//  Copyright © 2018 Teamproject. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
     var DataSource: [(lap: String, time: String?)] = []
    var timeobject: [Double] = []
    
    @IBOutlet weak var laptimeOutlet: UILabel!
    @IBOutlet weak var newlap: UIButton!
    @IBOutlet weak var lapsview: UIButton!
    @IBOutlet weak var currentlapno: UILabel!
    @IBOutlet weak var stopbuttonoutlet: UIButton!
    @IBOutlet weak var startButtonoutlet: UIButton!
    @IBOutlet weak var logoOutlet: UIButton!
    var timer = Timer()
    var isTimerRunning = false
    var total_time = 0
    var lap_time = 0
    var lappresent = 0
    @IBOutlet var doubletap: UITapGestureRecognizer!
    @IBOutlet var singletap: UITapGestureRecognizer!
    @IBOutlet weak var newLapoutlet: UIButton!
    @IBOutlet weak var totaltime: UILabel!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        stopbuttonoutlet.isEnabled = false
        stopbuttonoutlet.isHidden = true
        newLapoutlet.isEnabled = false
        newLapoutlet.isHidden = true
        newlap.isEnabled = false
        newlap.isHidden = true
        singletap.require(toFail: doubletap)
        print(startButtonoutlet.imageView!.tag)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    @IBAction func logoAction(_ sender: UIButton) {
        for data in DataSource{
            if data.lap == "Lap \(currentlapno.text!)"{
                lappresent = 1
            }
            
        }
        if lappresent == 1 {
            lappresent = 0
            performSegue(withIdentifier: "laptable", sender: self)
            
        } else {
            DataSource.append(("Lap \(currentlapno.text!)", laptimeOutlet.text))
            performSegue(withIdentifier: "laptable", sender: DataSource)
        }
        
        
    }
 
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! LapTableViewController
        
        if segue.identifier == "laptable"{
            destination.myDataSource = DataSource
            if currentlapno.text! != "0"{
            destination.averagetime = total_time/Int(currentlapno.text!)!
            } else {
                destination.averagetime = total_time
            }
            }
    }
    
    @IBAction func newLapaction(_ sender: UIButton) {
        DataSource.append(("Lap \(currentlapno.text!)", laptimeOutlet.text))
        currentlapno.text = String(Int(currentlapno.text!)!+1)
        lap_time=0
        
    }
    @IBAction func stopButtonaction(_ sender: UIButton) {
        startButtonoutlet.isEnabled = true
        startButtonoutlet.isHidden = false
        stopbuttonoutlet.isEnabled = false
        stopbuttonoutlet.isHidden = true
        
        logoOutlet.isEnabled = true
        logoOutlet.isHidden = false
        newLapoutlet.isEnabled = false
        newLapoutlet.isHidden = true
        timer.invalidate()
        
    }
    @IBAction func startdoubletapAction(_ sender: UITapGestureRecognizer) {
        DataSource = []
        lap_time = 0
        total_time = 0
        totaltime.text = "00:00:00.0"
        currentlapno.text = "0"
        laptimeOutlet.text = "00:00:00.0"
        
        
    }
    @IBAction func startsingletapAction(_ sender: UITapGestureRecognizer) {
        startButtonoutlet.isEnabled = false
        startButtonoutlet.isHidden = true
        stopbuttonoutlet.isEnabled = true
        stopbuttonoutlet.isHidden = false
        
        logoOutlet.isEnabled = false
        logoOutlet.isHidden = true
        newLapoutlet.isEnabled = true
        newLapoutlet.isHidden = false
        if currentlapno.text == "0"{
            currentlapno.text = "1"
        }
        runTimer()
        
    }
    
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }
   
    @objc func updateTimer() {
        total_time += 1
        lap_time += 1
        totaltime.text = timeString(time: TimeInterval(total_time))
        laptimeOutlet.text = timeString(time: TimeInterval(lap_time))
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        
    }
    
}

