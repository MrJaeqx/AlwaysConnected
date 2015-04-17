//
//  TimePickerViewController.swift
//  AlwaysConnected
//
//  Created by Fhict on 17/04/15.
//  Copyright (c) 2015 Fhict. All rights reserved.
//

import UIKit

class TimePickerViewController: UIViewController {
    
    @IBOutlet var timePicker: UIDatePicker?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func timeChanged(sender: UIDatePicker) {
        
        var dateFormatter = NSDateFormatter()
        
        dateFormatter.dateFormat = "HH:mm"
        
        var strDate = dateFormatter.stringFromDate(timePicker!.date)
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://larsjaeqx.nl/alwaysconnected/storedata.php")!)
        request.HTTPMethod = "POST"
        let postString = "time=" + strDate
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil {
                println("error=\(error)")
                return
            }
            
            println("response = \(response)")
            
            let responseString = NSString(data: data, encoding: NSUTF8StringEncoding)
            println("responseString = \(responseString)")
        }
        
        task.resume()
    }
    
    @IBAction func swipeDetected(sender: UISwipeGestureRecognizer) {
        println("Right swipe")
        //performSegueWithIdentifier("nextView", sender: self)
    }
}
