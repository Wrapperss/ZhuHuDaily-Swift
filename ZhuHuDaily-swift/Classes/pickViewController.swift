//
//  pickViewController.swift
//  ZhuHuDaily-swift
//
//  Created by Wrappers Zhang on 2017/6/24.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

import UIKit
protocol PickViewControllerDelegate {
    func getDate(_ date: Date) -> Void;
}

class pickViewController: UIViewController {

    @IBOutlet weak var pickView: UIDatePicker!
    var delegate: PickViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func blockButtonClick(_ sender: Any) {
        if delegate != nil {
            delegate?.getDate(pickView.date.addingTimeInterval(8 * 60 * 60))
            self.dismiss(animated: true, completion: nil)
        }
    }
}
