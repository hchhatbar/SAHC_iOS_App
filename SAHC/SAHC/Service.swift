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
    
    enum AuthenticationError: ErrorType {
        case AuthenticationAPINotReachable
        case AuthenticationCallThrewError(error: NSError)
        case AuthenticationResponseNotOK(httpCode: Int)
        case AuthenticationResponseMalformed(data: NSData, error: NSError)
        case AuthenticationResponseUnrecognized(json: NSDictionary)
    }
    
    // should initialize only once
    static let sharedInstance = Service()
    
    // MARK: REST API endpoints
    // TODO: need to confirm with REST team that this will be delivered over HTTPS
    // right now there is a App Transport Exception in Info.plist
    static let restBaseURL: String = "http://sathiapi.staging.southasianheartcenter.org"
    static let authenticationEndPoint: String = "authenticate.php"
    static let questionsEndPoint: String = "questions.php"
    // MARK: End REST API endpoints
    
    // keep session key here
    // optional since we might have a key on first run, so check (lazy to keep "")
    var sessionKey: String?
    
    // set constructor to private because we want to only use the sharedInstance
    private init(){
        
    }
    
    /**
     *   Method will authenticate a user against the API based on the credentials passed
     *   and store the session key within the class. Returns true or false whether the
     *   API authentication passed or failed
     *
     *   Reason for the completion block of code is so we have the ability to throw exceptions
     *   whether its network related, server error related, etc. but at the same time return
     *   the true or false as intended
     *
     **/
    func authenticate(authCode: String, email: String, phoneNumber: String, completion: (inner: () throws -> Bool) -> ()) {
        
        let jsonStr = "json={\"authCode\":\"\(authCode)\",\"email\":\"\(email)\",\"p\":\"\(phoneNumber)\"}&Submit=Submit".stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
        
        
        let session = NSURLSession.sharedSession()
        let request = NSMutableURLRequest(URL: NSURL(string: Service.authenticationEndPoint, relativeToURL: NSURL(string: Service.restBaseURL))!)
        
        // setup post call
        request.HTTPMethod = "POST";
        request.HTTPBody = jsonStr!.dataUsingEncoding(NSUTF8StringEncoding)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        // API service doesn't accept application/json, but x-www-form-urlencoded
        //request.HTTPBody = payLoad.description.dataUsingEncoding(NSUTF8StringEncoding)
        //request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        let task: NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler:  { (data, response, error) in
            // do stuff with response, data & error here
            
            // first check the obvious, error
            if let error = error {
                if error.code == NSURLErrorNotConnectedToInternet {
                    completion(inner: { throw AuthenticationError.AuthenticationAPINotReachable })
                    return
                }
                completion(inner: { throw AuthenticationError.AuthenticationCallThrewError(error: error) })
                return
            }
            
            // check the actual response headers
            if let httpResponse = response as? NSHTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    completion(inner: {throw AuthenticationError.AuthenticationResponseNotOK(httpCode: httpResponse.statusCode) })
                    return
                }
            }
            
            // at this point, valid json data was passed in
            do{
                if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSDictionary {
                    
                    if let success = json["success"] as? String {
                        if success == "true" {
                            if let sessionKey = json["sessionKey"] as? String {
                                self.sessionKey = sessionKey
                                completion(inner: { return true })
                                return
                            } else {
                                completion(inner: {throw AuthenticationError.AuthenticationResponseUnrecognized(json: json)} )
                                return
                            }
                        } else if success == "false" {
                            completion(inner: { return false })
                            return
                        }
                    } else {
                        completion(inner: {throw AuthenticationError.AuthenticationResponseUnrecognized(json: json) })
                        return
                    }
                }
                
            } catch let parseError as NSError {
                NSLog("error occured: %@",parseError.localizedDescription)
                completion(inner: {throw AuthenticationError.AuthenticationResponseMalformed(data: data!, error: parseError) })
                return
            }
            
        })
        
        task.resume()
    }
    
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
        //        let url = NSURL( string: "https://southasianheartcenter.org/sathiapi/questions.php")
        let url = NSURL( string: "http://sathiapi.staging.southasianheartcenter.org/questions.php")
        //let postString = "json={\"key\":\"1e34dfd3cbf383d348a5081be48cc821\", \"authCode\":\"o56xQZpm\", \"p\":\"4086884646\" }"
        let postString = "{\"key\":\"62c2c1e7282edb\"}"
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
