//
//  Signed_In.swift
//  YGOReview
//
//  Created by stlp on 5/29/22.
//

import Foundation
import UIKit

class TableViewDelegateAndDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    weak var vc : UIViewController?
    weak var table : UITableView?
    var userType : String?
    
    // TODO: Initilize this with the names of cards from an API call
    var data = ["H - Heated Heart", "O - Oversoul", "W-Wing Catapult"]
    // Return the number of rows for the table.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    // Provide a cell object for each row.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Fetch a cell of the appropriate type.
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // Configure the cell’s contents.
        cell.textLabel!.text = data[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cardVC = vc?.storyboard?.instantiateViewController(withIdentifier: "detail") as! CardVC
        cardVC.card = data[indexPath.row]
        cardVC.signedIn = (userType == "new" || userType == "old")
        vc?.navigationController?.pushViewController(cardVC, animated: true)
        self.table!.deselectRow(at: indexPath, animated: true)
        
    }
    
}


class SignedInVC: UIViewController {
    
    @IBOutlet weak var table: UITableView!
    
    public var userType = ""
    var dataSourceAndDelegate = TableViewDelegateAndDataSource()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        dataSourceAndDelegate.vc = self
        dataSourceAndDelegate.userType = userType
        dataSourceAndDelegate.table = table
        
        table.delegate = dataSourceAndDelegate
        table.dataSource = dataSourceAndDelegate
        
        self.title = "Cards"
        navigationController?.navigationBar.topItem?.title = "Sign Out"
    }
    
}
