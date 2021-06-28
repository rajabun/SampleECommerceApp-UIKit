//
//  LoginViewController.swift
//  SampleECommerceApp-UIKit
//
//  Created by Muhammad Rajab Priharsanto on 26/06/21.
//

import UIKit
import GoogleSignIn

class LoginViewController: UIViewController {

    @IBOutlet weak var signInButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        // Automatically sign in the user.
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
    }

    @IBAction func signInButtonFunction(_ sender: UIButton) {
        performSegue(withIdentifier: "GoToHome", sender: self)
    }
    
    @IBAction func didTapSignOut(_ sender: AnyObject) {
      GIDSignIn.sharedInstance().signOut()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
