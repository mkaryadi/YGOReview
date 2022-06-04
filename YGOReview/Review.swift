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
    
    init(_ author: String, _ card: String, _ desc: String, _ stars: Int) {
        self.author = author
        self.card = card
        self.desc = desc
        self.stars = stars
    }
}
