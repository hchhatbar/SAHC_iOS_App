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
        
        
        Service.getQuestionsWithSuccess { (questions) -> Void in
            let json = JSON(data: questions)
            println(json)
            var dataAccess = DataAccess()
            dataAccess.saveQuestions(json)
            var results = dataAccess.getQuestions()
        }
        
        
        
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

