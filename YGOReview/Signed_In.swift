//
//  Signed_In.swift
//  YGOReview
//
//  Created by stlp on 5/29/22.
//

import Foundation
import UIKit
class Signed_In: UIViewController{
    public var Label = "";
    override func viewDidLoad() {
        super.viewDidLoad()
        Labels.text = Label
        print(self.toolbarItems)
    }
    @IBOutlet weak var Labels: UILabel!
}
