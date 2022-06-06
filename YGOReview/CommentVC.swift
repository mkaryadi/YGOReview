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
    var signedIn = false
    var delegateAndDataSource = CommentTableDelegateAndDataSource()
    var dataRepo = DataRepository()
    var email = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentTableView.delegate = delegateAndDataSource
        commentTableView.dataSource = delegateAndDataSource
        delegateAndDataSource.data = review!.comments
            
        starLabel.text = "Number of Stars: \(review!.stars)"
        reviewTextView.text = review!.desc
        // Do any additional setup after loading the view.
        
        let addCommentButton = UIBarButtonItem(title: "Add a Comment", style: .plain, target: self, action: #selector(CommentVC.addComment))
        self.navigationItem.rightBarButtonItem = addCommentButton
        
        print("Here's the review comments:", review?.comments)
    }
    
    @objc(addComment)
    func addComment(){
        if signedIn {
            let alert = UIAlertController(title: "Leave a Comment", message: "Write a comment on this review", preferredStyle: .alert)
            
            alert.addTextField { textField in
                textField.placeholder = "Write your comment here..."
            }
            
            alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { _ in
                if !(alert.textFields?.first?.text?.isEmpty ?? false) {
                    self.dataRepo.postComment(self.review?.author, self.review?.card, self.email, alert.textFields?.first?.text)
                    self.delegateAndDataSource.data.append("\(self.email) says: \((alert.textFields?.first?.text)!)")
                    self.commentTableView.reloadData()
                } else {
                    print("Empty comment, dismissing...")
                    alert.dismiss(animated: true)
                }
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            self.present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: "Registration Required", message: "You must have an account to leave a comment!", preferredStyle: .alert)
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
