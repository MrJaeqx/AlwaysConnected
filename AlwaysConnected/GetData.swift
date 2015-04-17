//
//  GetData.swift
//  AlwaysConnected
//
//  Created by Fhict on 17/04/15.
//  Copyright (c) 2015 Fhict. All rights reserved.
//

import Foundation



class GetData {
    var dt: DataStruct = DataStruct()
    var dataCur: [Int] = [0,0,0]
    var dataMax: [Int] = [0,0,0]
    var timeStart: [String] = ["","",""]
    var timeEnd: [String] = ["","",""]
    
    func GetFromUrl(url: String) {
        let url = NSURL(string: url)
        let request = NSURLRequest(URL: url!)
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            self.DecodeJSON(data)
        }
        
        task.resume();
    }
    
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
            println(dt.dataCur)
        }
    }
    
    func GetDataCur(index: Int) -> String {
        println(dt.dataCur)
        return String(dataCur[index])
    }
    
    func GetDataMax(index: Int) -> String {
        return String(self.dataMax[index])
    }
    
    func GetTimeStart(index: Int) -> String {
        return self.timeStart[index]
    }
    
    func GetTimeEnd(index: Int) -> String {
        return self.timeEnd[index]
    }
    
    func GetProgress(index: Int) -> Float {
        return Float(self.dataCur[index]) / Float(self.dataMax[index])
    }
}
