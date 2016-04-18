//
//  QuestionaireAnswerTableViewCell.swift
//  SAHC
//
//  Created by Michael Hari on 3/30/16.
//  Copyright © 2016 AppForCause. All rights reserved.
//

import UIKit

protocol QuestionaireAnswerDelegate {
    func didSelectItemNumber(answerNumber: Int)
    func didUnselectItemNumber(answerNumber: Int)
}

class QuestionaireAnswerTableViewCell: UITableViewCell {
    
    var buttonType: QuestionViewController.QuestionType = QuestionViewController.QuestionType.SingleSelect
    var answerNumber: Int = 0 // needs to be set properly
    var delegate: QuestionaireAnswerDelegate?

    @IBOutlet var answerLabel: UILabel!
    @IBOutlet var selectionChoiceBtn: UIButton!
    
    @IBAction func selectionBtnPressed(sender: AnyObject) {
        
        if self.selectionChoiceBtn.selected {
            if buttonType == QuestionViewController.QuestionType.SingleSelect {
                self.selectionChoiceBtn.setImage(UIImage(named: "radio_btn_off"), forState: UIControlState.Normal)
            } else if buttonType == QuestionViewController.QuestionType.MultiSelect {
                self.selectionChoiceBtn.setImage(UIImage(named: "checkbox_btn_off"), forState: UIControlState.Normal)
            } else {
                
            }
            
            self.selectionChoiceBtn.selected = false
            
            self.delegate?.didUnselectItemNumber(self.answerNumber)
        } else {
            if buttonType == QuestionViewController.QuestionType.SingleSelect {
                self.selectionChoiceBtn.setImage(UIImage(named: "radio_btn_on"), forState: UIControlState.Selected)
            } else if buttonType == QuestionViewController.QuestionType.MultiSelect {
                self.selectionChoiceBtn.setImage(UIImage(named: "checkbox_btn_on"), forState: UIControlState.Selected)
            } else {
                
            }
            
            self.selectionChoiceBtn.selected=true
            
            self.delegate?.didSelectItemNumber(self.answerNumber)
        }
    }
    
    
}