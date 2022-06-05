//
//  CardVC.swift
//  YGOReview
//
//  Created by Matthew Karyadi on 6/4/22.
//

import UIKit

class CardVC: UIViewController {
    @IBOutlet var cardImage: UIImageView!
    @IBOutlet var cardName: UILabel!
    @IBOutlet var cardText: UITextView!
    let apiBaseURL = "https://db.ygoprodeck.com/api/v7/cardinfo.php?name="
    var card = "Nirvana High Paladin"
    
    var signedIn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let apiCall = apiBaseURL + card.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let apiCallURL = URL(string: apiCall)!
        getJsonCardData(apiCallURL)
        // Do any additional setup after loading the view.
        // TODO: Set up API call to grab card info and populate the VC accordingly
        
        title = card
    }
    
    @IBAction func checkReviews(_ sender: Any) {
        let reviewVC = storyboard?.instantiateViewController(withIdentifier: "review") as! ReviewVC
        reviewVC.card = card
        reviewVC.signedIn = signedIn
        navigationController?.pushViewController(reviewVC, animated: true)
    }
    
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        let imageView = sender.view as! UIImageView
        let newImageView = UIImageView(image: imageView.image)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        newImageView.addGestureRecognizer(tap)
        self.view.addSubview(newImageView)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }

    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
    
    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
     }
     */
    
    func getJsonCardData(_ url: URL) {
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
                    let info = actualObject![0]
                    DispatchQueue.main.async {
                        self.cardName.text = (info["name"] as! String)
                        self.cardText.text = (info["desc"] as! String)
                    }
                    if let cardImages = info["card_images"] as? [[String: Any]] {
                        let imageURLString = cardImages[0]["image_url"] as! String
                        guard let imageURL = URL(string: imageURLString) else {
                            return
                        }

                        self.cardImage.loadImage(withURL: imageURL)
                    }
                }
            }
            catch {
                print("Something went boom")
            }
        }
        session.resume()
    }
    
    func getJson(_ url: URL) {
        let session = URLSession.shared.dataTask(with: url) {
            data, response, error in
            
            if response != nil {
                if (response! as! HTTPURLResponse).statusCode != 200 {
                    print("Something went wrong! \(error)")
                }
            }
            
            let httpResponse = response! as! HTTPURLResponse
            
            print(data)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!)
                print(json)
                //        if let subjects = json as? [Any] {
                //            for subject in subjects {
                //                if let dictionary = subject as? [String : Any] {
                //                    let title = dictionary["title"] as? String
                //                    let description = dictionary["desc"] as? String
                //                    if let questions = dictionary["questions"] as? [Any] {
                //                        var questionList : [String] = []
                //                        var choicesList : [[String]] = []
                //                        var answerIndexList : [Int] = []
                //                        for question in questions {
                //                            if let questionDictionary = question as? [String : Any] {
                //                                let answerIndex = questionDictionary["answer"] as? String
                //                                let questionText = questionDictionary["text"] as? String
                //                                let choices = questionDictionary["answers"] as? [String]
                //                                print("\(title) \(answerIndex)")
                ////                                answerIndexList.append(answerIndex!)
                ////                                choicesList.append(choices!)
                ////                                questionList.append(questionText!)
                //                            }
                //                        }
                ////                        problemsDict[title!] = questionList
                ////                        choicesDict[title!] = choicesList
                ////                        answersDict[title!] = answerIndexList
                //                    }
                ////                    self.subjects.append(title!)
                ////                    subjectDescription.append(description!)
                //                }
                //            }
                //        }
            }
            catch {
                print("Something went boom")
            }
        }
        session.resume()
    }
}


extension UIImageView {
    func loadImage(withURL url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
