//
//  FirstViewController.swift
//  SAHC
//
//  Created by Hemen Chhatbar on 10/25/15.
//  Copyright (c) 2015 AppForCause. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    var scroll = UIScrollView()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        if let path = NSBundle.mainBundle().pathForResource("questions", ofType: "json")
        {
            if let jsonData = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: nil)
            {
                var error1: NSError?
                if let jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &error1) as? NSDictionary
                {
                    
                    if let persons : NSArray = jsonResult["questions"] as? NSArray
                    {
                        println(persons.count)
                        // Do stuff
                    }
                }
            }
        }
        
        let url = NSURL( string: "https://southasianheartcenter.org/sathiapi/questions.php")
        let request = NSMutableURLRequest(URL: url!)
        
        request.HTTPMethod = "POST";
        let postString = "json={\"key\":\"1e34dfd3cbf383d348a5081be48cc821\"}"
        
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request){
            data, response, error in
            
            if error != nil{
                println("error =\(error)")
                return
            }
            
            println("******** response = \(response)")
            
            let responseString = NSString(data: data, encoding:NSASCIIStringEncoding)
            
            println("******** response data = \(responseString)")
            
            //var err : NSError?
            //var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: &err) as? NSDictionary
            
                            var error1: NSError?
                if let jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &error1) as? NSDictionary
                {
                    
                    if let persons : NSArray = jsonResult["questions"] as? NSArray
                    {
                        println(persons.count)
                        // Do stuff
                    }
                }
           

            var jsonData: NSData = responseString!.dataUsingEncoding(NSUTF8StringEncoding)!

            var error:NSError? = nil
            if let jsonObject: AnyObject = NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.AllowFragments, error:&error) {
                if let dict = jsonObject as? NSDictionary {
                    println(dict)
                } else {
                    println("not a dictionary")
                }
            } else {
                println("Could not parse JSON: \(error!)")
            }
            
            //if let parseJSON = json{
            //    var firstVal = parseJSON["questionId"] as? String
           // }
            
        }
        task.resume()
        
        //Service.getQuestions({ (questions) -> Void in
        //    println(questions)
        //} )
   
        // Get the #1 app name from iTunes and SwiftyJSON
       /* Service.getQuestionsWithSuccess { (questions) -> Void in
            let json = JSON(data: questions)
            
            var dataAccess = DataAccess()
            dataAccess.saveQuestions(json)
            var results = dataAccess.getQuestions()
            // More soon...
            
            //1
           /* 
                       if let appArray = json["feed"]["entry"].array {
                //2
                var apps = [AppModel]()
                
                //3
                for appDict in appArray {
                    var appName: String? = appDict["im:name"]["label"].string
                    var appURL: String? = appDict["im:image"][0]["label"].string
                    
                    var app = AppModel(name: appName, appStoreURL: appURL)
                    apps.append(app)
                }
                
                //4
                println(apps)
        
        var dataAccess = DataAccess()
        dataAccess.saveQuestions()
        var results = dataAccess.getQuestions()*/
    } */
    }
    
    func getQuestionsFromJSON(){
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        scroll.backgroundColor = UIColor.redColor();
        scroll.scrollEnabled = true
        scroll.pagingEnabled = true;
        self.view.addSubview(scroll)
    }

    @IBAction func introductionClicked(sender: AnyObject) {
        var questionTableViewController = QuestionTableViewController()
        self.view.addSubview(questionTableViewController.view)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

