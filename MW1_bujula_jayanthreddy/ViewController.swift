//
//  ViewController.swift
//  MW1_bujula_jayanthreddy
//
//  Created by Jayanth Bujula on 9/29/18.
//  Copyright © 2018 Teamproject. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // Holds lap numbers and times
    var DataSource: [(lap: String, time: String?)] = []
    @IBOutlet weak var logoOutlet: UIButton!
    @IBOutlet weak var currentlapno: UILabel!
    @IBOutlet weak var buttonOutlet: UIButton!
    @IBOutlet weak var laptimeOutlet: UILabel!
    var timer = Timer()
    var isTimerRunning = false
    // Total lap time
    var total_time: Float = 0
    // current lap time
    var lap_time:Float = 0
    // Flag that specifies the button that is curently present on UI 0-start, 1-stop.
    var startstop = 0
    //Flag that specifies the button that is curently present on UI 0-logobutton, 1-new lap.
    var logobutton = 0
    @IBOutlet var doubletap: UITapGestureRecognizer!
    @IBOutlet var singletap: UITapGestureRecognizer!
    @IBOutlet weak var totaltime: UILabel!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // To show navigation and tool bar on the home view
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.setToolbarHidden(true, animated: false)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        singletap.require(toFail: doubletap)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // To hide navigation and tool bar on the home view
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.setToolbarHidden(false, animated: true)
    }
    
    @IBAction func logoAction(_ sender: UIButton) {
        // sugue to the tableview controller
        if logobutton == 0{
            var index = 0
            for data in DataSource{
                if data.lap == "Lap \(currentlapno.text!)"{
                    DataSource.remove(at: index)
                }
                index += 1
            }
            // Append the current lap time to the datasource object and then segue
            DataSource.append(("Lap \(currentlapno.text!)", laptimeOutlet.text))
            performSegue(withIdentifier: "laptable", sender: DataSource)
            
        } else{
            // Perform new lap by incrementing the current lap value
            var index = 0
            for data in DataSource{
                if data.lap == "Lap \(currentlapno.text!)"{
                    DataSource.remove(at: index)
                    
                }
                index += 1
            }
            DataSource.append(("Lap \(currentlapno.text!)", laptimeOutlet.text))
            currentlapno.text = String(Int(currentlapno.text!)!+1)
            lap_time=0
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! LapTableViewController
        // assign the datasource object values to the destination myDatasource object
        if segue.identifier == "laptable"{
            destination.myDataSource = DataSource
            if currentlapno.text! != "0"{
                destination.averagetime = total_time/Float(currentlapno.text!)!
            } else {
                destination.averagetime = total_time
            }
        }
    }
    
    
    // Reset values on double tapping the start button
    @IBAction func startdoubletapAction(_ sender: UITapGestureRecognizer) {
        if startstop == 0 {
            DataSource = []
            lap_time = 0
            total_time = 0
            totaltime.text = "00:00:00.0"
            currentlapno.text = "0"
            laptimeOutlet.text = "00:00:00.0"
        }
        
    }
    @IBAction func startsingletapAction(_ sender: UITapGestureRecognizer) {
        // start timer on taping start button
        if startstop == 0 {
            if currentlapno.text == "0"{
                currentlapno.text = "1"
            }
            buttonOutlet.setImage(UIImage(named: "stop-timer.png")!, for: .normal)
            logoOutlet.setImage(UIImage(named: "new-lap.png")!, for: .normal)
            startstop = 1
            logobutton = 1
            
            runTimer()
        } else{
            //stop timer
            buttonOutlet.setImage(UIImage(named: "start-timer.png")!, for: .normal)
            logoOutlet.setImage(UIImage(named: "running-logo.png")!, for: .normal)
            startstop = 0
            logobutton = 0
            timer.invalidate()
        }
        
    }
    
    // timer function that calls updateTimer func for every 0.1 sec
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        total_time += 0.1
        lap_time += 0.1
        totaltime.text = timeString(time: TimeInterval(total_time))
        laptimeOutlet.text = timeString(time: TimeInterval(lap_time))
    }
    // convert time to hours, min, sec, millisec.
    func timeString(time:TimeInterval) -> String {
        let ms = Int(time*10)%10
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d:%02d.%d", hours, minutes, seconds, ms)
        
    }
    
}

