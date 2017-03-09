//
//  SignUpVC.swift
//  socialClone
//
//  Created by Zhiyuan Cui on 3/9/17.
//  Copyright © 2017 Zhiyuan Cui. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class SignUpParentVC: ButtonBarPagerTabStripViewController{

    let purpleInspireColor = UIColor(red:0.13, green:0.03, blue:0.25, alpha:1.0)
    @IBOutlet weak var signInLabel: UILabel!
    
    @IBOutlet weak var ButtonBar: UIView!
    
    override func viewDidLoad() {

        
        // change selected bar color
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.selectedBarBackgroundColor = purpleInspireColor
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 14)
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .black
            newCell?.label.textColor = self?.purpleInspireColor
        }
        super.viewDidLoad()
        
        signInLabel.attributedText = getSignInAttributedText()
        let SignInTap = UITapGestureRecognizer(target: self, action: #selector(self.signInTap))
        signInLabel.isUserInteractionEnabled = true
        signInLabel.addGestureRecognizer(SignInTap)
        
        
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let pager1 = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier:"WithPhone")
        let pager2 = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier:"WithEmail")
        
        return [pager2, pager1]
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
