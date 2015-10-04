//
//  ViewController.swift
//  poll
//
//  Created by sylvain Cristofari on 02/08/2015.
//  Copyright (c) 2015 sylvain Cristofari. All rights reserved.
//

import UIKit

class DetailController: UIViewController
{

    @IBOutlet weak var question: UILabel!
    
    var poll: Poll! {
        didSet {
            if ( question != nil ) {
                question!.text = poll.question
            }
        }
    }
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if ( poll != nil ) {
            question.text = poll.question
        }
    }
}