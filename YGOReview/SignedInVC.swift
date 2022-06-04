//
//  Signed_In.swift
//  YGOReview
//
//  Created by stlp on 5/29/22.
//

import Foundation
import UIKit

class TableViewDelegateAndDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var data = ["H - Heated Heart", "O - Oversoul", "W - Wing Catapault"]
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
}


class SignedInVC: UIViewController {
    
    @IBOutlet weak var table: UITableView!
    
    public var userType = ""
    var dataSourceAndDelegate = TableViewDelegateAndDataSource()
    
    override func viewDidLoad() {
        print(userType)
        super.viewDidLoad()
        table.delegate = dataSourceAndDelegate
        table.dataSource = dataSourceAndDelegate
    }
    
}
