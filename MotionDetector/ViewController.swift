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
    let motionManager = CMMotionActivityManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        historyTable.dataSource = self
        debugPrint("view did load")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        startActivities()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateTable(data: [CMMotionActivity]) {
        self.data = data.filter({
            $0.confidence == .High && $0.valid
        })
        .sort({
            $0.startDate.compare($1.startDate) == NSComparisonResult.OrderedDescending
        })
        historyTable.reloadData()
    }

    //MARK: CMMotionActivityManager stuff
    func startActivities() {
        if CMMotionActivityManager.isActivityAvailable() {
            self.motionManager.startActivityUpdatesToQueue(NSOperationQueue.currentQueue()!, withHandler: {
                activity in
                    guard let activity = activity where activity.valid else { return }
                    self.currentLabel.text = activity.humanReadable()
            })
        
            self.motionManager.queryActivityStartingFromDate(NSDate.init(timeIntervalSince1970: 0), toDate: NSDate(), toQueue: NSOperationQueue.currentQueue()!, withHandler: {
                activities, error in
                    if let _ = error {
                        debugPrint(error)
                    }
                    if let act = activities {
                        self.updateTable(act)
                    }
                    else {
                        self.updateTable([])
                    }
            })
        }
        else {
            fatalError("No activites available")
        }
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
        if act.humanReadable() == "" {
            debugPrint("Weird case \(act)")
        }
        cell.textLabel?.text = "\(act.humanReadable())"
        cell.detailTextLabel?.text = "\(act.startDate) confidence: \(act.confidence.humanReadable())"
        
        return cell
    }
}

