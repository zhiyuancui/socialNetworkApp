//
//  SignUpWithEmail.swift
//  socialClone
//
//  Created by Zhiyuan Cui on 3/9/17.
//  Copyright © 2017 Zhiyuan Cui. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class SignUpWithEmailVC: UIViewController, IndicatorInfoProvider,UITextFieldDelegate {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailField.delegate = self;
        
        //Disable Next button
        nextButton.isUserInteractionEnabled = false;
        nextButton.alpha = 0.38;
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let length = (textField.text?.characters.count)! - range.length + string.characters.count;
        if length > 0, isValidEmail(email: emailField.text!){
            nextButton.isUserInteractionEnabled = true;
            nextButton.alpha = 1;
        }else{
            nextButton.isUserInteractionEnabled = false;
            nextButton.alpha = 0.38;
        }
        return true;
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo{
        return IndicatorInfo(title:"Email")
    }
    
    func isValidEmail(email: String) -> Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    @IBAction func NextTapped(_ sender: UIButton) {
        
    }
    
}
