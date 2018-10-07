//
//  LapTableViewController.swift
//  MW1_bujula_jayanthreddy
//
//  Created by Jayanth Bujula on 9/29/18.
//  Copyright © 2018 Teamproject. All rights reserved.
//

import UIKit

class LapTableViewController: UITableViewController {
    // average lap time
    var averagetime:Float = 0
    var displayaverageinformat : String = "0"
    var myDataSource: [(lap: String, time: String?)] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // display average lap value on the bar item
        displayaverageinformat = timeString(time: TimeInterval(averagetime))
        let averagelaptime = UIBarButtonItem(title: "Average Lap Time : \(displayaverageinformat)",style: .plain,target: self, action: nil)
        let flex = UIBarButtonItem(barButtonSystemItem:.flexibleSpace, target: self, action: nil)
        self.toolbarItems = [flex, averagelaptime, flex]
        
    }
    // convert time to hours, minutes, sec, milli sec format
    func timeString(time:TimeInterval) -> String {
        let ms = Int(time*10)%10
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d:%02d.%d", hours, minutes, seconds, ms)
        
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myDataSource.count
    }

    // inject values into table cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "my table identifier", for: indexPath)
        cell.textLabel?.text = myDataSource[indexPath[1]].lap + "  " + myDataSource[indexPath[1]].time!
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
