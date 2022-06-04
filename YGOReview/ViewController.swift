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
    
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    
    override func viewDidLoad() {
        passwordField.isSecureTextEntry = true
        super.viewDidLoad()
        
        let dataRepo = DataRepository()
        dataRepo.getAllReviewsByUser("ramirost")
        dataRepo.getAllReviewsByCard("Tornado Dragon")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Clear the email and password fields after signing out
        emailField.text = ""
        passwordField.text = ""
    }
    
    @IBAction func enterEmail(_ sender: Any) {
        email = emailField.text!
    }

    @IBAction func enterPassword(_ sender: Any) {
        print("ALeterrr PASSWorD SUBMITTeD")
        password = passwordField.text!
    }

    @IBAction func signUp(_ sender: Any) {
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
                
                let newUserVC = self.storyboard?.instantiateViewController(withIdentifier: "Success") as! SignedInVC
                newUserVC.userType = "new"
                self.navigationController?.pushViewController(newUserVC, animated: true)
                
            })
        }
    }

    @IBAction func signIn(_ sender: Any) {
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
                
                let loggedInUserVC = self.storyboard?.instantiateViewController(withIdentifier: "Success") as! SignedInVC
                loggedInUserVC.userType = "old"
                self.navigationController?.pushViewController(loggedInUserVC, animated: true)
                
            })
        }
    }
    
    @IBAction func continueAsGuest(_ sender: Any) {
        let loginedInGuestVC = storyboard?.instantiateViewController(withIdentifier: "Success") as! SignedInVC
        loginedInGuestVC.userType = "guest"
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
}
