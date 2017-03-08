//
//  ViewController.swift
//  socialClone
//
//  Created by Zhiyuan Cui on 3/3/17.
//  Copyright © 2017 Zhiyuan Cui. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase

class SignInVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var signUpLabel: UILabel!
    @IBOutlet weak var forgetPwdLabel: UILabel!
    
    @IBOutlet weak var userField: UITextField!
    @IBOutlet weak var pwdField: UITextField!
    
    @IBOutlet weak var loginWithFB: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    var loginTryTimes = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Setup delegate
        userField.delegate = self;
        pwdField.delegate = self;
        userField.tag = 1;
        pwdField.tag = 2;
        
        //Disable Login Button
        loginButton.isUserInteractionEnabled = false;
        loginButton.alpha = 0.38;

        
        //Setup FB auth
        signUpLabel.attributedText = getSignUpAttributedText()
        forgetPwdLabel.attributedText = getForgetPwdArributedText()
        
        // Setup gesture listener
        let signUpTap = UITapGestureRecognizer(target: self, action: #selector(self.signUpTapFunction))
        signUpLabel.isUserInteractionEnabled = true
        signUpLabel.addGestureRecognizer(signUpTap)
        

        let forgetPwdTap = UITapGestureRecognizer(target: self, action: #selector(self.forgetPwdTapFunction))
        forgetPwdLabel.isUserInteractionEnabled = true
        forgetPwdLabel.addGestureRecognizer(forgetPwdTap)
        
        let letSignInTap = UITapGestureRecognizer(target: self, action: #selector(self.SignInWithFBTapFunction))
        loginWithFB.isUserInteractionEnabled = true
        loginWithFB.addGestureRecognizer(letSignInTap)


    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.tag ==  2, userField.text != ""{
            let length = (textField.text?.characters.count)! - range.length + string.characters.count;
            if( length > 0 ){
                loginButton.isUserInteractionEnabled = true;
                loginButton.alpha = 1;
            }
        }
        return true;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func FBSignInTapped(_ sender: UIButton) {
        
        let fbLoginManager = FBSDKLoginManager()
        
        fbLoginManager.logIn(withReadPermissions: ["email"], from: self){
            (result, error) in
            if error != nil{
                print("MyPhotoApp: Unable to authenticate with Facebook. \(error)")
            }else if result?.isCancelled == true {
                print("MyPhotoApp: User cancelled facebook authentication")
            }else{
                print("MyPhotoApp:successfully authenticated with facebook")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                
                self.firebaseAuth(credential)
                
                
            }
        }

    }
    
    @IBAction func LoginTapped(_ sender: UIButton) {
        if let user = userField.text, let pwd = pwdField.text{
            FIRAuth.auth()?.signIn(withEmail: user, password: pwd, completion: {(user, error) in
                if error == nil{
                    //Move to next view
                    print("MyPhotoApp: success signed in")
                }else{
                    //password not match
                    if self.loginTryTimes == 0{
                        let alert = UIAlertController(title:"Incorrect Password",message:"Your password is not correct.", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title:"Try Again", style:UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated:true, completion:nil)
                    }else {
                        let alert = UIAlertController(title:"Forgotten Password?",message:"Your password is not correct.", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title:"Try Again", style:UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated:true, completion:nil)
                    }
                    self.loginTryTimes+=1;
                }
                
            })
        }
    }
    
    func firebaseAuth(_ credential: FIRAuthCredential){
        FIRAuth.auth()?.signIn(with: credential, completion:{
            (user, error) in
            if error != nil{
                print("MyPhotoApp: Unable to authenticate with Firebase. \(error)")
            }else{
                print("MyPhotoApp: successfully authenticated with Firebase")
            }
        })
    }
    
    //Create an attributeText for signup Label
    func getSignUpAttributedText() -> NSMutableAttributedString{
        let myMutableString = NSMutableAttributedString(
            string: "Don't have an account? Sign up")
        
        myMutableString.addAttribute(
            NSForegroundColorAttributeName,
            value: UIColor.init(hex: "1565C0"),
            range: NSRange(
                location:23,
                length:7))
        
        return myMutableString
    }
    
    //Create an attributeText for Forget Password Label Label
    func getForgetPwdArributedText() -> NSMutableAttributedString{
        let myMutableString = NSMutableAttributedString(
            string: "Forgot your login details? Get help signing in.")
        
        myMutableString.addAttribute(
            NSForegroundColorAttributeName,
            value: UIColor.init(hex: "1565C0"),
            range: NSRange(
                location:27,
                length:20))
        
        return myMutableString
    }
    
    func signUpTapFunction(sender: UITapGestureRecognizer){
        let tapLocation = sender.location(in: signUpLabel)
        let index = signUpLabel.indexOfAttributedTextCharacterAtPoint(point: tapLocation)
        if( index > 22 ){
            //Bring up sing up page
            print("sign up")
        }
    }

    func forgetPwdTapFunction(sender: UITapGestureRecognizer){
        let tapLocation = sender.location(in: forgetPwdLabel)
        let index = forgetPwdLabel.indexOfAttributedTextCharacterAtPoint(point: tapLocation)
        if( index > 27 ){
            //Bring up forget password page
            print("forget password")
        }
    }
    
    func SignInWithFBTapFunction(sender: UITapGestureRecognizer){
        
    }

    
}


///////////////////////////////////////////////////////////////////
///                         EXTENSIONS                          ///
///////////////////////////////////////////////////////////////////
extension UIColor{
    //Init UIColor from hex string
    convenience init(hex: String){
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0;
        
        var rgbValue: UInt64 = 0;
        
        scanner.scanHexInt64(&rgbValue)
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
}

extension UILabel {
    ///Find the index of character (in the attributedText) at point
    func indexOfAttributedTextCharacterAtPoint(point: CGPoint) -> Int {
        assert(self.attributedText != nil, "This method is developed for attributed string")
        
        let attributedText = NSMutableAttributedString(attributedString: self.attributedText!)
        attributedText.addAttributes([NSFontAttributeName: self.font], range: NSMakeRange(0, (self.attributedText?.string.characters.count)!))
        
        
        let textStorage = NSTextStorage(attributedString: attributedText)
        
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize(width: self.frame.width, height: (self.frame.height-100)))
        
        //Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        
        //Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.maximumNumberOfLines = self.numberOfLines
        textContainer.lineBreakMode = self.lineBreakMode
        textContainer.size = self.bounds.size
        
        print("Points: \(point)")
        let alignedPoint = CGPoint.init(x: point.x-47, y: point.y-20)
        print("alignedPoint: \(alignedPoint)")
        let index = layoutManager.characterIndex(for: alignedPoint, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        print("Index: \(index)")
        
        return index
    }
}

