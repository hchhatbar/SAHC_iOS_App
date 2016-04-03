//
//  HRAViewController.swift
//  SAHC
//
//  Created by Hemen Chhatbar on 10/25/15.
//  Copyright (c) 2015 AppForCause. All rights reserved.
//

import UIKit

class HRAViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let initialHRACheckList: [HRAItem] = [
        HRAItem(image: UIImage(named: "Introduction")!, itemName: "Get Started"),
        HRAItem(image: UIImage(named: "PersonalStatus")!, itemName: "Personal Status"),
        HRAItem(image: UIImage(named: "MedicalHistory")!, itemName: "Medical History"),
        HRAItem(image: UIImage(named: "Exercise")!, itemName: "Exercise"),
        HRAItem(image: UIImage(named: "Diet")!, itemName: "Diet"),
        HRAItem(image: UIImage(named: "Sleep")!, itemName: "Sleep"),
        HRAItem(image: UIImage(named: "Conclusion")!, itemName: "Next Steps")
    ]

//    var scroll = UIScrollView()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print(Service.sharedInstance.sessionKey)
        
        Service.getQuestionsWithSuccess { (questions) -> Void in
            let json = JSON(data: questions)
            print(json)
            //let dataAccess = DataAccess()
            //DataAccess.sharedInstance.saveQuestions(json)
            _ = DataAccess.sharedInstance.getQuestions()
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
   
//    func getQuestionsFromJSON(){
//        
//        
//    }
//    
//    override func viewWillAppear(animated: Bool) {
//        scroll.backgroundColor = UIColor.redColor();
//        scroll.scrollEnabled = true
//        scroll.pagingEnabled = true;
//        self.view.addSubview(scroll)
//    }
//
//    @IBAction func introductionClicked(sender: AnyObject) {
//        let questionTableViewController = QuestionTableViewController()
//        self.view.addSubview(questionTableViewController.view)
//    }
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let index = sender as! Int
        
        if segue.destinationViewController is QuestionViewController {
            let viewController = segue.destinationViewController as! QuestionViewController
            viewController.navigationItem.title = self.initialHRACheckList[index].itemName
        }
    }
    
    // MARK: UITableViewDataSource methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.initialHRACheckList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("HRATableViewCell") as! HRATableViewCell
        
        cell.itemImageView.image = self.initialHRACheckList[indexPath.row].image
        cell.itemNameLbl.text = self.initialHRACheckList[indexPath.row].itemName
        //cell.progressView.progress = self.initialHRACheckList[indexPath.row].progress
        
        return cell
    }
    
    // MARK: End UITableViewDataSource methods
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("DashboardToQuestionaireSegue", sender: indexPath.row)
    }
    
    // MARK: UITableViewDelegate methods
    
    // MARK: End UITableViewDelegate methods
    
    // MARK: Target-Actions
    
    @IBAction func signoutBtnPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: End Target-Actions

}

