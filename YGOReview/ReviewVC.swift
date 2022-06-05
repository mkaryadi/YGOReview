//
//  ReviewVC.swift
//  YGOReview
//
//  Created by Matthew Karyadi on 6/4/22.
//

import UIKit

class ReviewTableDelegateAndDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    weak var vc : ReviewVC?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vc!.reviewArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel!.text = vc!.reviewArray[indexPath.row].author
        cell.detailTextLabel!.text = "\(vc!.reviewArray[indexPath.row].stars) stars"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: Go to the VC that will allow for viewing the full review and commenting
    }
    
}


class ReviewVC: UIViewController {
    var card = ""
    var signedIn = false
    var datarepo = DataRepository()
    var reviewArray: [Review] = []

    @IBOutlet weak var noReviewsLabel: UITableView!
    @IBOutlet weak var reviewTable: UITableView!
    
    let delegateAndDataSource = ReviewTableDelegateAndDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "Reviews for \(card)"
        let addReviewButton = UIBarButtonItem(title: "Add a Review", style: .plain, target: self, action: #selector(ReviewVC.segueToReviewWriting))
        self.navigationItem.rightBarButtonItem = addReviewButton
        delegateAndDataSource.vc = self
        reviewTable.delegate = delegateAndDataSource
        reviewTable.dataSource = delegateAndDataSource
        datarepo.getAllReviewsByCard(card, self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
