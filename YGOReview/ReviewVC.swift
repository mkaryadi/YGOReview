//
//  ReviewVC.swift
//  YGOReview
//
//  Created by Matthew Karyadi on 6/4/22.
//

import UIKit

class ReviewVC: UIViewController {
    var card = ""
    var signedIn = false
    var datarepo = DataRepository()
    var reviewArray: [Review] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Reviews for \(card)"
        let addReviewButton = UIBarButtonItem(title: "Add a Review", style: .plain, target: self, action: #selector(ReviewVC.segueToReviewWriting))
        self.navigationItem.rightBarButtonItem = addReviewButton
        datarepo.getAllReviewsByCard(card, self)
    }
    
    @objc(segueToReviewWriting)
    func segueToReviewWriting() {
        if (signedIn) {
            let writingVC = storyboard?.instantiateViewController(withIdentifier: "writing") as! WritingVC
            writingVC.card = card
            navigationController?.pushViewController(writingVC, animated: true)
        } else {
            let alert = UIAlertController(title: "Reigstration Required", message: "You must have an account to leave a review!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
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
