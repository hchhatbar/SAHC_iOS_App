//
//  QuestionViewController.swift
//  SAHC
//
//  Created by Hemen Chhatbar on 11/15/15.
//  Copyright (c) 2015 AppForCause. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, QuestionaireAnswerDelegate {
    
    @IBOutlet var answerTableView: UITableView!
    
    @IBOutlet var answerTxtView: UITextView!
    @IBOutlet var questionLbl: UILabel!
    enum QuestionType: String {
        case SingleSelect = "rb",
        MultiSelect = "ch",
        InputAnswer = "txt"
    }
    
    var questions: [SurveyQuestion] = [SurveyQuestion]()
    var currentQuestion: SurveyQuestion?
    
    var questionType: QuestionType?
    var questionNumber: Int = 0
    
    var answerList: [AnswerOption] = [AnswerOption]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.questions.sortInPlace({ $0.sortOrder < $1.sortOrder })
        self.loadQuestion(0)
    }
    
    private func loadQuestion(questionNumber: Int) {
        
        self.currentQuestion = self.questions[questionNumber]
        
        // set question type
        if let type = self.currentQuestion?.type {
            self.questionType = QuestionType(rawValue: type)
            if self.questionType == QuestionType.InputAnswer {
                self.answerTableView.hidden = true
                self.answerTxtView.hidden = false
                self.answerTxtView.becomeFirstResponder()
            } else {
                self.answerTableView.hidden = false
                self.answerTxtView.hidden = true
                self.answerTxtView.resignFirstResponder()
            }
        }
        
        // TODO: should load different kind of tableview based on selection or show a text input if necessary
        if let questionTxt = self.currentQuestion?.text {
            self.questionLbl.text = "Q: " + questionTxt
        }
        
        
        if let answerOptions = self.currentQuestion?.answerOptions {
            self.answerList = answerOptions
            self.answerList.sortInPlace({$0.sortOrder < $1.sortOrder})
        }
        
        self.questionNumber = questionNumber
        
        self.answerTableView.reloadData()
        
    }
    
    // MARK: UITableViewDataSource methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answerList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("QuestionaireAnswerTableViewCell") as! QuestionaireAnswerTableViewCell
        
        let currentAnswer = answerList[indexPath.row]
        
        cell.answerNumber = indexPath.row
        cell.answerLabel.text = currentAnswer.description
        cell.delegate = self
        
        if currentAnswer.selected {
            if self.questionType == QuestionType.SingleSelect || self.questionType == QuestionType.MultiSelect {
                cell.selectionChoiceBtn.setImage(UIImage(named: "radio_btn_on"), forState: UIControlState.Selected)
                cell.selectionChoiceBtn.selected = true
            }

        } else {
            if self.questionType == QuestionType.SingleSelect || self.questionType == QuestionType.MultiSelect {
                cell.selectionChoiceBtn.setImage(UIImage(named: "radio_btn_off"), forState: UIControlState.Normal)
                cell.selectionChoiceBtn.selected = false
            } else {
                
            }

        }
        
        return cell
    }
    
    // MARK: End UITableViewDataSource methods
    
    // MARK: QuestionaireAnswerDelegate methods
    
    func didSelectItemNumber(answerNumber: Int) {
        
        self.answerList[answerNumber].selected = true
        
        // if in single select mode, unselect any other selected buttons
        if self.answerList.count > 0 && self.questionType == QuestionType.SingleSelect {
            
            for index in 0...self.answerList.count - 1 {
                if index != answerNumber {
                    self.answerList[index].selected = false
                }
            }
            
            self.answerTableView.reloadData()
        }
        
    }
    
    func didUnselectItemNumber(answerNumber: Int) {
        // don't need to do anything
    }
    
    // MARK: End QuestionaireAnswerDelegate methods
    
    // MARK: Target-Actions
    
    @IBAction func leftArrowBtnPressed(sender: AnyObject) {
        
        if questionNumber == 0 {
            self.navigationController?.popViewControllerAnimated(true)
        } else {
            // load previous question
            self.loadQuestion(self.questionNumber-1)
        }
    }
    
    @IBAction func rightArrowBtnPressed(sender: AnyObject) {
        
        // load next question
        if self.questionNumber + 1 == self.questions.count {
            self.navigationController?.popViewControllerAnimated(true)
        } else {
            self.loadQuestion(self.questionNumber+1)
        }
    }
    
    @IBAction func infoBtnPressed(sender: AnyObject) {
        
        let alert = UIAlertController(title: self.currentQuestion?.label, message: self.currentQuestion?.tipText, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Okay"), style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    
    // MARK: End Target-Actions

}
