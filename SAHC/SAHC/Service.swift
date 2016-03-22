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
        
        /*var session = NSURLSession.sharedSession()
        
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
        
        loadDataTask.resume()*/
        
        let session = NSURLSession.sharedSession()
        let url = NSURL( string: "https://southasianheartcenter.org/sathiapi/questions.php")
        let postString = "json={\"key\":\"1e34dfd3cbf383d348a5081be48cc821\"}"
        let request = NSMutableURLRequest(URL: url!)
        
        request.HTTPMethod = "POST";
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        
            
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: {(data: NSData?, response: NSURLResponse?, error: NSError?)  in
            // notice that I can omit the types of data, response and error
            
            // your code
            if let responseError = error {
                completion(data: nil, error: responseError)
            } else if let httpResponse = response as? NSHTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    let statusError = NSError(domain:"com.sahc", code:httpResponse.statusCode, userInfo:[NSLocalizedDescriptionKey : "HTTP status code has unexpected value."])
                    completion(data: nil, error: statusError)
                } else {
                    
                    let responseString = NSString(data: data!, encoding:NSASCIIStringEncoding)
                    
                    print("******** response data = \(responseString)")
                    let jsonData: NSData = responseString!.dataUsingEncoding(NSUTF8StringEncoding)!
                    
                    //let error:NSError? = nil
                    var jsonObject: AnyObject
                    do {
                        try jsonObject = NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.AllowFragments)
                        if let dict = jsonObject as? NSDictionary {
                            print(dict)
                        } else {
                            print("not a dictionary")
                        }
                        
                    } catch _ {
                        
                    }
                    
                    completion(data: jsonData, error: nil)
                }
            }
            
         

            })
        task.resume()
        
    }
}
