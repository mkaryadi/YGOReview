//
//  CommentVC.swift
//  YGOReview
//
//  Created by Matthew Karyadi on 6/5/22.
//

import UIKit

class CommentTableDelegateAndDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    var data: [String] = []
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "comment", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
    
}

class CommentVC: UIViewController {
    @IBOutlet weak var starLabel: UILabel!
    @IBOutlet weak var reviewTextView: UITextView!
    @IBOutlet weak var commentTableView: UITableView!
    
    weak var review: Review?
    var delegateAndDataSource = CommentTableDelegateAndDataSource()
    var stars = 1
    var reviewText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentTableView.delegate = delegateAndDataSource
        commentTableView.dataSource = delegateAndDataSource
        delegateAndDataSource.data = review!.comments
            
        starLabel.text = "Number of Stars: \(review!.stars)"
        reviewTextView.text = review!.desc
        // Do any additional setup after loading the view.
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
