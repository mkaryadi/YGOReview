//
//  ViewController.swift
//  YGOReview
//
//  Created by Matthew Karyadi on 5/26/22.
//
import Firebase
import FirebaseAuth
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Clear the email and password fields after signing out
        emailField.text = ""
        passwordField.text = ""
        navigationController?.isNavigationBarHidden = true
    }

    @IBAction func signUp(_ sender: Any) {
        email = emailField.text!
        password = passwordField.text!
        if password.isEmpty || email.isEmpty ||
            email.count < 6 || password.count < 6
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
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { [self] _, error in
                guard error == nil else {
                    self.displayAlert("Firebase Login Issue", "Can't login you in, please try again later",
                                      "FireBase login Issues")
                    return
                }
                
                let newUserVC = self.storyboard?.instantiateViewController(withIdentifier: "Success") as! SignedInVC
                newUserVC.userType = "new"
                newUserVC.email = self.email
                self.navigationController?.pushViewController(newUserVC, animated: true)
                self.navigationController?.isNavigationBarHidden = false
            })
        }
    }

    @IBAction func signIn(_ sender: Any) {
        email = emailField.text!
        password = passwordField.text!
        if password.isEmpty && email.isEmpty ||
            email.count < 6 && password.count < 6
        {
            displayAlert("Invalid Email/Password", "Please Enter a Valid Email/Password",
                         "An email Password error")
        } else if password.isEmpty || password.count < 6 && !email.isEmpty &&
            email.count > 6 && email.contains("@")
        {
            displayAlert("Invalid Password", "Please Enter a Valid Password" + " 6 digits",
                         "An Password error")
        } else if email.isEmpty || email.count < 6 || !email.contains("@") &&
            !password.isEmpty && password.count > 6
        {
            displayAlert("Invalid Email", "Please Enter a Valid jemail" + " with @ also",
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
                loggedInUserVC.email = self.email
                self.navigationController?.pushViewController(loggedInUserVC, animated: true)
                self.navigationController?.isNavigationBarHidden = false
            })
        }
    }
    
    @IBAction func continueAsGuest(_ sender: Any) {
        let loginedInGuestVC = storyboard?.instantiateViewController(withIdentifier: "Success") as! SignedInVC
        loginedInGuestVC.userType = "guest"
        navigationController?.pushViewController(loginedInGuestVC, animated: true)
        navigationController?.isNavigationBarHidden = false
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
