//
//  WritingVC.swift
//  YGOReview
//
//  Created by Matthew Karyadi on 6/4/22.
//

import UIKit

class WritingVC: UIViewController, UITextViewDelegate {
    @IBOutlet var reviewTextView: UITextView!
    @IBOutlet var starRating: UITextField!
    
    var card = "Nirvana High Paladin"
    let datarepo = DataRepository()
    var email = ""
    
    @IBAction func submitReview(_ sender: Any) {
        let numStars = Int(starRating.text!) ?? 0
        if reviewTextView.textColor == .lightGray {
            let alert = UIAlertController(title: "You haven't typed anything", message: "Write up a great review before you try to post one!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        } else if numStars < 1 || numStars > 5 {
            let alert = UIAlertController(title: "Invalid number of stars", message: "Rate this card between 1 and 5 stars!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        } else {
            print(email)
            datarepo.postReview(email, card, numStars: numStars, description: reviewTextView.text!)
            navigationController?.popViewController(animated: true)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        reviewTextView.delegate = self
        reviewTextView.textColor = .lightGray
        // Do any additional setup after loading the view.
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = ""
            textView.textColor = .black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Write your review here..."
            textView.textColor = .lightGray
        }
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
