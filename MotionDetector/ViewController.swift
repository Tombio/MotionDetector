//
//  ViewController.swift
//  MotionDetector
//
//  Created by Tomi Lahtinen on 29/03/16.
//  Copyright © 2016 Tomi Lahtinen. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var currentLabel: UILabel!
    @IBOutlet weak var historyTable: UITableView!
    
    var data: [CMMotionActivity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        historyTable.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateTable(data: [CMMotionActivity]) {
        self.data = data.sort({
            $0.startDate.compare($1.startDate) == NSComparisonResult.OrderedDescending
        })
        historyTable.reloadData()
    }
    
    // MARK: UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        let act = data[indexPath.row]
        cell.textLabel?.text = "\(act.humanReadable())"
        cell.detailTextLabel?.text = "\(act.startDate) confidence: \(act.confidence.humanReadable())"
        
        return cell
    }
}

