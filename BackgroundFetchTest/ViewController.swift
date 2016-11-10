//
//  ViewController.swift
//  BackgroundFetchTest
//
//  Created by Paul Wilkinson on 30/08/2016.
//  Copyright © 2016 Paul Wilkinson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var picker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let nc = NotificationCenter.default
        
        nc.addObserver(self, selector: #selector(ViewController.updateLabels), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateLabels()
    }
    
    @objc func updateLabels() {
        
        let defaults = UserDefaults.standard
        let backgroundTime = defaults.object(forKey: "background") as? String
        let suspendTime = defaults.object(forKey: "suspend") as? String
        
        label1.text! = backgroundTime ?? "No background fetch"
        label2.text! = suspendTime ?? "Never suspended"
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func datePicked(_ sender: UIDatePicker) {
        print(sender.date)
    }


}

