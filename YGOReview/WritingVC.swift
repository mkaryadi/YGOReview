//
//  WritingVC.swift
//  YGOReview
//
//  Created by Matthew Karyadi on 6/4/22.
//

import UIKit

class WritingVC: UIViewController, UITextViewDelegate {
    @IBOutlet weak var reviewTextView: UITextView!
    @IBOutlet weak var starRating: UITextField!
    var card = "Nirvana High Paladin"
    let datarepo = DataRepository()
    @IBAction func submitReview(_ sender: Any) {
        // TODO: Validate and submit the review
        if(reviewTextView.textColor == .lightGray){
            let alert = UIAlertController(title: "You haven't typed anything", message: "Write up a great review before you try to post one!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
        else{
            datarepo.postReview("ramirost", card, numStars: Int(starRating.text!)!, description: reviewTextView.text!)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        reviewTextView.delegate = self
        reviewTextView.textColor = .lightGray
        // Do any additional setup after loading the view.
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if (textView.textColor == .lightGray) {
            textView.text = ""
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if (textView.text.isEmpty) {
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
