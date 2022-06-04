//
//  CardVC.swift
//  YGOReview
//
//  Created by Matthew Karyadi on 6/4/22.
//

import UIKit

class CardVC: UIViewController {
    
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var cardName: UILabel!
    @IBOutlet weak var cardText: UILabel!
    
    var card = "Nirvana High Paladin"
    var signedIn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // TODO: Set up API call to grab card info and populate the VC accordingly
        
        self.title = card
    }
    
    @IBAction func checkReviews(_ sender: Any) {
        let reviewVC = self.storyboard?.instantiateViewController(withIdentifier: "review") as! ReviewVC
        reviewVC.card = card
        reviewVC.signedIn = signedIn
        self.navigationController?.pushViewController(reviewVC, animated: true)
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
