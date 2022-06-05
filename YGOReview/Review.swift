//
//  Review.swift
//  YGOReview
//
//  Created by Matthew Karyadi on 6/4/22.
//

import UIKit

class Review: NSObject {
    var author : String
    var card : String
    var desc : String
    var stars : Int
    var comments : [String]
    
    init(_ author: String, _ card: String, _ desc: String, _ stars: Int, _ comments: [String]) {
        self.author = author
        self.card = card
        self.desc = desc
        self.stars = stars
        self.comments = comments
    }
}
