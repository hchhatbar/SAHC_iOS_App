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
    
    class func getQuestionsWithSuccess(success: ((questions: NSData!) -> Void)) {
        
        loadDataFromURL(NSURL(string: restURL)!, completion:{(data, error) -> Void in
            if let urlData = data {
                success(questions: urlData)
            }
        })
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
