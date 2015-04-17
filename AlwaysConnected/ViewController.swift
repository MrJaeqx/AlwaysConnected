//
//  ViewController.swift
//  AlwaysConnected
//
//  Created by Fhict on 16/04/15.
//  Copyright (c) 2015 Fhict. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var getData = GetData()
    var dt = DataStruct()
    
    @IBOutlet var ts1DataCur: UILabel?
    @IBOutlet var ts1DataMax: UILabel?
    @IBOutlet var ts1TimeStart: UILabel?
    @IBOutlet var ts1TimeEnd: UILabel?
    @IBOutlet var ts1Prog: UIProgressView?
    
    @IBOutlet var ts2DataCur: UILabel?
    @IBOutlet var ts2DataMax: UILabel?
    @IBOutlet var ts2TimeStart: UILabel?
    @IBOutlet var ts2TimeEnd: UILabel?
    @IBOutlet var ts2Prog: UIProgressView?
    
    @IBOutlet var ts3DataCur: UILabel?
    @IBOutlet var ts3DataMax: UILabel?
    @IBOutlet var ts3TimeStart: UILabel?
    @IBOutlet var ts3TimeEnd: UILabel?
    @IBOutlet var ts3Prog: UIProgressView?
    
    @IBOutlet var timePicker: UIDatePicker?

    func DecodeJSON(d: NSData) {
        var jsonError: NSError?
        let json = NSJSONSerialization.JSONObjectWithData(d, options: nil, error: &jsonError) as! NSDictionary
        
        if let unwrappedError = jsonError {
            println("json error: \(unwrappedError)")
        } else {
            dt = DataStruct(dataCur: json.valueForKeyPath("slots.DataCur") as! [Int],
                dataMax: json.valueForKeyPath("slots.DataMax") as! [Int],
                timeStart: json.valueForKeyPath("slots.TimeStart") as! [String],
                timeEnd: json.valueForKeyPath("slots.TimeEnd") as! [String])
        }
        
        ts1DataCur?.text = String(dt.dataCur[0])
        ts1DataMax?.text = String(dt.dataMax[0])
        ts1TimeStart?.text = dt.timeStart[0]
        ts1TimeEnd?.text = dt.timeEnd[0]
        ts1Prog?.progress = (Float(dt.dataCur[0])/Float(dt.dataMax[0]))
        
        ts2DataCur?.text = String(dt.dataCur[1])
        ts2DataMax?.text = String(dt.dataMax[1])
        ts2TimeStart?.text = dt.timeStart[1]
        ts2TimeEnd?.text = dt.timeEnd[1]
        ts2Prog?.progress = (Float(dt.dataCur[1])/Float(dt.dataMax[1]))
        
        ts3DataCur?.text = String(dt.dataCur[2])
        ts3DataMax?.text = String(dt.dataMax[2])
        ts3TimeStart?.text = dt.timeStart[2]
        ts3TimeEnd?.text = dt.timeEnd[2]
        ts3Prog?.progress = (Float(dt.dataCur[2])/Float(dt.dataMax[2]))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let url = NSURL(string: "http://larsjaeqx.nl/alwaysconnected/data.php")
        let request = NSURLRequest(URL: url!)
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            self.DecodeJSON(data)
        }
        
        task.resume()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

