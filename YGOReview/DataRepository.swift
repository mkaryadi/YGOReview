//
//  DataRepository.swift
//  YGOReview
//
//  Created by stlp on 5/31/22.
//

import UIKit

class DataRepository: NSObject {
    
//    private let API_URL = "https://desolate-ridge-13493.herokuapp.com/"

    private let ALL_REVIEWS_BY_USER_URL = "https://desolate-ridge-13493.herokuapp.com/allReviewsByUser?author="
    private let ALL_REVIEWS_BY_CARD_URL = "https://desolate-ridge-13493.herokuapp.com/allReviewsByCard?card="
    
    func getAllReviewsByUser(_ user: String) {
        let encodedUser = user.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: "\(ALL_REVIEWS_BY_USER_URL)\(encodedUser)")
        getJson(url!)
    }
    
    func getAllReviewsByCard(_ card: String) {
        let encodedeCard = card.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: "\(ALL_REVIEWS_BY_CARD_URL)\(encodedeCard)")
        getJson(url!)
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
