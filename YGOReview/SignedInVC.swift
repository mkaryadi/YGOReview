//
//  SignedInVC.swift
//  YGOReview
//
//  Created by stlp on 5/29/22.
//

import Foundation
import UIKit

class CardTableDataSourceAndDelegate: NSObject, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    weak var vc: SignedInVC?
    weak var table: UITableView?
    var userType: String?
    var filteredData: [String] = []
    
    var data = ["H - Heated Heart", "O - Oversoul", "W-Wing Catapult"]
    // Return the number of rows for the table.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    // Provide a cell object for each row.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Fetch a cell of the appropriate type.
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // Configure the cell’s contents.
        cell.textLabel!.text = filteredData[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cardVC = vc?.storyboard?.instantiateViewController(withIdentifier: "detail") as! CardVC
        cardVC.card = filteredData[indexPath.row]
        cardVC.signedIn = (userType == "new" || userType == "old")
        cardVC.email = vc!.email
        vc?.navigationController?.pushViewController(cardVC, animated: true)
        table!.deselectRow(at: indexPath, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = searchText.isEmpty ? data : data.filter { (item: String) -> Bool in
            // If dataItem matches the searchText, return true to include it
            item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        
        table!.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredData = data
        table!.reloadData()
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}

class SignedInVC: UIViewController {
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var table: UITableView!
    
    var email = ""
    public var userType = ""
    var dataSourceAndDelegate = CardTableDataSourceAndDelegate()
    var sortByButton : UIBarButtonItem?
    var alphaList : [String]?
    var sortType = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSourceAndDelegate.vc = self
        dataSourceAndDelegate.userType = userType
        dataSourceAndDelegate.table = table
        searchBar.delegate = dataSourceAndDelegate
        
        let DIFOURL = URL(string: "https://db.ygoprodeck.com/api/v7/cardinfo.php?cardset=dimension%20force")!
        getJsonCardData(DIFOURL)
        title = "Cards"
        navigationController?.navigationBar.backItem?.title = "Sign Out"
        sortByButton = UIBarButtonItem(title: "Sort By Rating", style: .plain, target: self, action: #selector(handleTap(sender:)))
        navigationItem.rightBarButtonItem = sortByButton
    }
    
    @objc func handleTap(sender: UIBarButtonItem) {
        if sortType {
            sender.title = "Sort by Rating"
            self.dataSourceAndDelegate.filteredData = self.alphaList ?? []
            self.table.reloadData()
            sortType = false
        } else {
            sender.title = "Sort Alphabetically"
            getListOfCardsByRating()
            sortType = true
        }
    }
    
    
    func getListOfCardsThruSearch(_ searchString: String!) {
        let searchURLBaseCall = "https://db.ygoprodeck.com/api/v7/cardinfo.php?fname="
        let myURLString = searchURLBaseCall + searchString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        print(myURLString)
        getJsonCardData(URL(string: myURLString)!)
    }
    
    func getJsonCardData(_ url: URL) {
        var cardNameList: [String] = []
        let session = URLSession.shared.dataTask(with: url) {
            data, response, error in
            
            if response != nil {
                if (response! as! HTTPURLResponse).statusCode != 200 {
                    print("Something went wrong! \(error)")
                }
            }
            
            let httpResponse = response! as! HTTPURLResponse
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!)
                print(json)
                if let dict = json as? [String: Any] {
                    print(dict)
                    let actualObject = dict["data"] as? [[String: Any]]
                    for info in actualObject! {
                        let cardName = (info["name"] as! String)
                        cardNameList.append(cardName)
                    }
                    DispatchQueue.main.async { [self] in
                        for card in cardNameList {
                            print(card)
                        }
                        self.dataSourceAndDelegate.data = cardNameList
                        dataSourceAndDelegate.filteredData = cardNameList
                        self.alphaList = cardNameList
                        self.table.delegate = dataSourceAndDelegate
                        self.table.dataSource = dataSourceAndDelegate
                        self.table.reloadData()
                    }
                }
            }
            catch {
                print("Something went boom")
            }
        }
        session.resume()
    }
    
    func getListOfCardsByRating() {
        var cardNameList: [String] = []
        var url = URL(string: "https://desolate-ridge-13493.herokuapp.com/cardsbyRating")!
        let session = URLSession.shared.dataTask(with: url) {
            data, response, error in
            
            if response != nil {
                if (response! as! HTTPURLResponse).statusCode != 200 {
                    print("Something went wrong! \(error)")
                }
            }
            
            let httpResponse = response! as! HTTPURLResponse
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!)
                print(json)
                if let actualObject = json as? [[String: Any]] {
                    for info in actualObject {
                        let cardName = (info["name"] as! String)
                        cardNameList.append(cardName)
                    }
                    DispatchQueue.main.async { [self] in
                        for card in cardNameList {
                            print(card)
                        }
                        self.dataSourceAndDelegate.data = cardNameList
                        dataSourceAndDelegate.filteredData = cardNameList
                        self.alphaList = cardNameList
                        self.table.delegate = dataSourceAndDelegate
                        self.table.dataSource = dataSourceAndDelegate
                        self.table.reloadData()
                    }
                }
            }
            catch {
                print("Something went boom")
            }
        }
        session.resume()
    }
}
