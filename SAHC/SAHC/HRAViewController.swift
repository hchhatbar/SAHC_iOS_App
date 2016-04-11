//
//  HRAViewController.swift
//  SAHC
//
//  Created by Hemen Chhatbar on 10/25/15.
//  Copyright (c) 2015 AppForCause. All rights reserved.
//

import UIKit
import CoreData

class HRAViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var checkListTblView: UITableView!
    var hud: MBProgressHUD = MBProgressHUD()
    
    var checkList: [SurveyCategory] = [SurveyCategory]()

//    var scroll = UIScrollView()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print(Service.sharedInstance.sessionKey)
        
        self.hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        self.hud.mode = MBProgressHUDMode.AnnularDeterminate
        self.hud.label.text = NSLocalizedString("Loading Questions...", comment: "Loading questions for spinner")
        
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), {
            
            Service.sharedInstance.refreshCategories { (inner: () throws -> Bool) -> Void in
                
                do {
                    let success = try inner() // get result
                    if success {
                        self.checkList = Service.sharedInstance.survey.categories
                        dispatch_async(dispatch_get_main_queue(), {
                            self.checkListTblView.reloadData()
                            self.hud.hideAnimated(true)
                        })
                    }
                } catch let error {
                    print(error)
                }
                
            }
            
            Service.sharedInstance.refreshQuestions { (inner: () throws -> Bool) -> Void in
                // dismiss spinner
                //                dispatch_async(dispatch_get_main_queue(), {
                //                    hud.hideAnimated(true)
                //                })
                
                do {
                    let success = try inner() // get result
                    if success {
                        // populate answers from db
                        for question in Service.sharedInstance.survey.questions {
                            // need to migrate this to DataController later
                            let moc = DataController.sharedInstance.managedObjectContext
                            let fetchRequest = NSFetchRequest(entityName: "SurveyAnswer")
                                fetchRequest.predicate = NSPredicate(format: "questionId == %d", question.id)
                                do {
                                    let surveyAnswers = try moc.executeFetchRequest(fetchRequest) as! [SurveyAnswer]
                                    
                                    // really inefficient, trying to resave the values back to db
                                    if surveyAnswers.count > 0 { // there should only be one result anyways
                                        for surveyAnswer in surveyAnswers {
                                            
                                            if question.type == QuestionViewController.QuestionType.InputAnswer.rawValue {
                                                
                                                question.answerTxt = surveyAnswer.answerTxt
                                                
                                            } else {
                                                
                                                for answerValue in surveyAnswer.answerValues as! [Int] {
                                                    
                                                    if let answerOptions = question.answerOptions {
                                                        for answerOption in answerOptions {
                                                            
                                                            if answerValue == answerOption.value {
                                                                answerOption.selected = true
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                
                                    }
                                } catch {
                                    fatalError("Failed to fetch: \(error)")
                                }
                            
                        }
                    } // end if success
                } catch let error {
                    print(error)
                }
                
            }
            
        })
        
//        Service.getQuestionsWithSuccess { (questions) -> Void in
//            let json = JSON(data: questions)
//            print(json)
//            //let dataAccess = DataAccess()
//            //DataAccess.sharedInstance.saveQuestions(json)
//            _ = DataAccess.sharedInstance.getQuestions()
//        }
        
        
        
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
            viewController.navigationItem.title = self.checkList[index].section
            viewController.questions = Service.sharedInstance.survey.questions.filter({ $0.category == String(index+1) })
        }
    }
    
    // MARK: UITableViewDataSource methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.checkList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("HRATableViewCell") as! HRATableViewCell
        
        cell.itemImageView.image = UIImage(named: self.checkList[indexPath.row].section)
        cell.itemNameLbl.text = self.checkList[indexPath.row].section
        //cell.progressView.progress = self.initialHRACheckList[indexPath.row].progress
        
        return cell
    }
    
    // MARK: End UITableViewDataSource methods
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // check if there are actual questions behind the category
        if Service.sharedInstance.survey.questions.filter({ $0.category == String(indexPath.row+1) }).count > 0 {
            self.performSegueWithIdentifier("DashboardToQuestionaireSegue", sender: indexPath.row)
        }
        
    }
    
    // MARK: UITableViewDelegate methods
    
    // MARK: End UITableViewDelegate methods
    
    // MARK: Target-Actions
    
    @IBAction func signoutBtnPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: End Target-Actions

}

