//
//  ViewController.swift
//  YGOReview
//
//  Created by Matthew Karyadi on 5/26/22.
//
import Firebase
import FirebaseAnalyticsOnDeviceConversionTarget
import FirebaseAnalyticsTarget
import FirebaseAppDistribution
import FirebaseAppDistributionTarget
import FirebaseAuth
import FirebaseAuthCombineSwift
import FirebaseCore
import FirebaseCoreDiagnostics
import FirebaseCoreInternal
import FirebaseDatabase
import FirebaseInstallations
import FirebaseSharedSwift
import UIKit

class ViewController: UIViewController {
    private var email = ""
    private var password = ""
    override func viewDidLoad() {
        PassWord.isSecureTextEntry = true
        super.viewDidLoad()
        
        let dataRepo = DataRepository()
        dataRepo.getAllReviewsByUser("ramirost")
        dataRepo.getAllReviewsByCard("Tornado Dragon")
    }

    @IBAction func Enter_Email(_ sender: Any) {
        email = Email.text!
    }
    
    @IBOutlet var PassWord: UITextField!
    @IBAction func Enter_Password(_ sender: Any) {
        print("ALeterrr PASSWorD SUBMITTeD")
        password = PassWord.text!
    }

    @IBAction func Sign_Up(_ sender: Any) {
        if password.isEmpty || email.isEmpty ||
            email.count < 6 || password.count < 6
        {
            print("ABDIWAHID PAssword is", password)
            print("DEBUG", "Email is", email)
            displayAlert("Invalid Email Password", "Please Enter a valid email/Password",
                         "An email Password error")
        } else if password.isEmpty || password.count < 6 && !email.isEmpty &&
            email.count > 6 && email.contains("@")
        {
            displayAlert("PASSWORD ERROR", "Please Enter a valid password" + " 6 digits",
                         "An Password error")
        } else if email.isEmpty || email.count < 6 || !email.contains("@") &&
            !password.isEmpty && password.count > 6
        {
            displayAlert("Email ERROR", "Please Enter a valid email" + " with @ also",
                         "An password error")
        } else {
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { _, error in
                guard error == nil else {
                    self.displayAlert("Firebase Login Issue", "Cant login you in try again later",
                                      "FireBase login Issues")
                    return
                }
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let Logined_In_User = storyboard.instantiateViewController(withIdentifier: "Success") as! Signed_In
                Logined_In_User.Label = "User logined in email is " + self.email
                self.navigationController?.pushViewController(Logined_In_User, animated: true)
                
            })
        }
    }

    @IBAction func Sign_In(_ sender: Any) {
        if password.isEmpty && email.isEmpty ||
            email.count < 6 && password.count < 6
        {
            displayAlert("Invalid Email Password", "Please Enter a valid email/Password",
                         "An email Password error")
        } else if password.isEmpty || password.count < 6 && !email.isEmpty &&
            email.count > 6 && email.contains("@")
        {
            displayAlert("PASSWORD ERROR", "Please Enter a valid password" + " 6 digits",
                         "An Password error")
        } else if email.isEmpty || email.count < 6 || !email.contains("@") &&
            !password.isEmpty && password.count > 6
        {
            displayAlert("Email ERROR", "Please Enter a valid email" + " with @ also",
                         "An password error")
        } else {
            FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { _, error in
                guard error == nil else {
                    self.displayAlert("Firebase Login Issue", "Cant Sign you in try again later",
                                      "FireBase login Issues")
                    return
                }
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let Logined_In_User = storyboard.instantiateViewController(withIdentifier: "Success") as! Signed_In
                Logined_In_User.Label = "This is a previous user " + self.email
                self.navigationController?.pushViewController(Logined_In_User, animated: true)
                
            })
        }
    }
    
    @IBAction func continueAsGuest(_ sender: Any) {
        let loginedInGuestVC = storyboard?.instantiateViewController(withIdentifier: "Success") as! Signed_In
        loginedInGuestVC.Label = "This is a guest"
        self.navigationController?.pushViewController(loginedInGuestVC, animated: true)
        
    }
    
    func displayAlert(_ title: String, _ message: String, _ LogError: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment:
            "Default action"), style: .default, handler: { _ in NSLog(LogError)
        }))
        present(alert, animated: true, completion: {
            NSLog("Alerted")
        })
    }
    
    @IBOutlet var Email: UITextField!
}
