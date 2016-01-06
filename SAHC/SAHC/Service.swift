//
//  Service.swift
//  SAHC
//
//  Created by Hemen Chhatbar on 11/6/15.
//  Copyright (c) 2015 AppForCause. All rights reserved.
//

import Foundation

let restURL = "http://afc.nijhazer.com/questions"

class Service {
    

        class func getQuestions(completion: ((questions:NSData!) -> Void)) {
        let url = NSURL( string: "https://southasianheartcenter.org/sathiapi/questions.php")
        
        //var picUrl = NSURL(string : "http://210.61.209.194:8088/SmarttvMedia/img/epi00001.png")
        var responseString : NSString = ""
        
        func forData(completion: (NSString) -> ()) {
            
            let request = NSMutableURLRequest( URL: url!)
            request.HTTPMethod = "POST"
            var s : NSString = ""
            let postString : String = "json={\"key\":\"1e34dfd3cbf383d348a5081be48cc821\"}"
            request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
            
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
                data, response, error in
                println("****** COMPLETION **********")
                println(data);
                if error != nil {
                    println("error=\(error)")
                    return
                } else {
                    
                    completion(NSString(data: data, encoding: NSUTF8StringEncoding)!)
                    println("****** COMPLETION **********")
                    println(data);
                }
            }
            task.resume()
            
        }
    }
    class func loadDataFromURL(url: NSURL, completion:(data: NSData?, error: NSError?) -> Void) {
        var session = NSURLSession.sharedSession()
        
        // Use NSURLSession to get data from an NSURL
        let loadDataTask = session.dataTaskWithURL(url, completionHandler: { (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
            if let responseError = error {
                completion(data: nil, error: responseError)
            } else if let httpResponse = response as? NSHTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    var statusError = NSError(domain:"com.sahc", code:httpResponse.statusCode, userInfo:[NSLocalizedDescriptionKey : "HTTP status code has unexpected value."])
                    completion(data: nil, error: statusError)
                } else {
                    completion(data: data, error: nil)
                }
            }
        })
        
        loadDataTask.resume()
    }
}
