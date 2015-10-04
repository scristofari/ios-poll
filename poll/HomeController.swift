//
//  ViewController.swift
//  poll
//
//  Created by Sylvain Cristofari on 02/08/2015.
//  Copyright (c) 2015 Sylvain Cristofari. All rights reserved.
//

import UIKit

class HomeController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    
    private let RestApi = PollService()
    
    @IBOutlet weak var dvjksdf: UIButton!
    
    var polls = [[Poll]]()
    
    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var pageDescription: UILabel!
    
    @IBOutlet weak var pageTable: UITableView! {
        didSet {
            pageTable.delegate = self
            pageTable.dataSource = self
        }
    }
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()  
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //alert("Connexion internet inexistante")
    }
    
    
    // MARK: Data
    func loadData() {
        RestApi.getPolls { (response: ListPollsReq?, error: NSError?) in
            if let ps = response?.polls {
                if ( ps.count > 0 ) {
                    self.polls.insert(ps, atIndex: 0)
                    self.pageTable.reloadData()
                }
            }
            if let err = error {
                print(response)
                self.alert(err.description)
            }
        }
    }
    
    // MARK: TableView
    func numberOfSectionsInTableView(tablView: UITableView) -> Int {
        return polls.count
    }
    
    private struct Identifiers {
        static let CellIdentifier = "poll"
        static let SegueIdentifier = "detailPoll"

    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let data = polls[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier(Identifiers.CellIdentifier, forIndexPath: indexPath) 
        cell.textLabel!.text = data.question
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return polls[section].count
    }
    
    // MARK: Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == Identifiers.SegueIdentifier) {
            let detail: DetailController = segue.destinationViewController as! DetailController
            
            let cell = sender as? UITableViewCell
            let indexPath = pageTable.indexPathForCell(cell!)
            detail.poll = polls[indexPath!.section][indexPath!.row]
        }
    }
    
    // MARK: Alert
    func alert(message: String) {
        let alert = UIAlertController(
            title: "Erreur",
            message: message,
            preferredStyle: UIAlertControllerStyle.Alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { (action: UIAlertAction) -> Void in
            //self.performSegueWithIdentifier(Identifiers.SegueIdentifier, sender: nil)
        }))
        presentViewController(alert, animated: true, completion: nil)
        
    }
}

