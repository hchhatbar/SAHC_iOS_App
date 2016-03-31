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
    enum QuestionType {
        case SingleSelect,MultiSelect
    }
    
    var questionType: QuestionType = QuestionType.SingleSelect
    
    var questionNumber: Int = 0
    
    let initialList: [AnswerItem] = [
        AnswerItem(answerValue: "None, I live alone"),
        AnswerItem(answerValue: "Spouse Only"),
        AnswerItem(answerValue: "Children/Spouse"),
        AnswerItem(answerValue: "Parents/Other Relatives"),
        AnswerItem(answerValue: "Significant Other")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: UITableViewDataSource methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("QuestionaireAnswerTableViewCell") as! QuestionaireAnswerTableViewCell
        
        let currentAnswer = initialList[indexPath.row]
        
        cell.answerNumber = indexPath.row
        cell.answerLabel.text = currentAnswer.answerValue
        cell.delegate = self
        
        if currentAnswer.selected {
            if currentAnswer.buttonType == AnswerItem.SelectionButtonType.Radio {
                cell.selectionChoiceBtn.setImage(UIImage(named: "radio_btn_on"), forState: UIControlState.Selected)
                cell.selectionChoiceBtn.selected = true
            } else {
                
            }

        } else {
            if currentAnswer.buttonType == AnswerItem.SelectionButtonType.Radio {
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
        
        self.initialList[answerNumber].selected = true
        
        // if in single select mode, unselect any other selected buttons
        if self.initialList.count > 0 && self.questionType == QuestionType.SingleSelect {
            
            for index in 0...self.initialList.count - 1 {
                if index != answerNumber {
                    self.initialList[index].selected = false
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
        }
    }
    
    @IBAction func rightArrowBtnPressed(sender: AnyObject) {
        
        // load next question
    }
    
    
    // MARK: End Target-Actions

}
