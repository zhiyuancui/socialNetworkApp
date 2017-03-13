//
//  SignUpNameVC.swift
//  socialClone
//
//  Created by Zhiyuan Cui on 3/13/17.
//  Copyright © 2017 Zhiyuan Cui. All rights reserved.
//

import UIKit

class SignUpNameVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var pwdField: UITextField!
    @IBOutlet weak var signInLabel: UILabel!
    
    var email:String = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()

        signInLabel.attributedText = getSignInAttributedText()
        let SignInTap = UITapGestureRecognizer(target: self, action: #selector(self.signInTap))
        signInLabel.isUserInteractionEnabled = true
        signInLabel.addGestureRecognizer(SignInTap)
        
        nameField.delegate = self;
        pwdField.delegate = self;
        nameField.tag = 1;
        pwdField.tag = 2;
        
        //Disable Login Button
        nextBtn.isUserInteractionEnabled = false;
        nextBtn.alpha = 0.38;

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func uploadPhotoTapped(_ sender: UIButton) {

        let alertController = UIAlertController(title: "Action Sheet", message: "Change Profile Photo", preferredStyle: .actionSheet)
        
        let takePhotoButton = UIAlertAction(title: "Take Photo", style: .default, handler: { (action) -> Void in
            print("Ok button tapped")
        })
        
        let fromLibButton = UIAlertAction(title: "Choose from Library", style: .default, handler: { (action) -> Void in
            print("Ok button tapped")
        })
        
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
            print("Cancel button tapped")
        })
        
        
        alertController.addAction(takePhotoButton)
        alertController.addAction(fromLibButton)
        alertController.addAction(cancelButton)
        
        self.navigationController!.present(alertController, animated: true, completion: nil)

    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.tag == 2 {
            let length = (textField.text?.characters.count)! - range.length + string.characters.count;
            if length > 6 {
                nextBtn.isUserInteractionEnabled = true;
                nextBtn.alpha = 1;
            }else{
                nextBtn.isUserInteractionEnabled = false;
                nextBtn.alpha = 0.38;
            }
        }
        return true;
    }
    
    @IBAction func NextTapped(_ sender: Any) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Create an attributeText for signup Label
    func getSignInAttributedText() -> NSMutableAttributedString{
        let myMutableString = NSMutableAttributedString(
            string: "Aleady have an account? Sign In")
        
        myMutableString.addAttribute(
            NSForegroundColorAttributeName,
            value: UIColor.init(hex: "1565C0"),
            range: NSRange(
                location:24,
                length:7))
        
        return myMutableString
    }
    
    func signInTap(){
        performSegue(withIdentifier: "goToSignIn", sender: nil)
    }

}
