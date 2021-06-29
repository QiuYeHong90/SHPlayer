//
//  ViewController.swift
//  SHPlayer
//
//  Created by yeqiu on 06/29/2021.
//  Copyright (c) 2021 yeqiu. All rights reserved.
//

import SHPlayer
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var playerView: SHPlayer!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       
        
    }
    @IBAction func tClick(_ sender: Any) {
        self.playerView.play(url: "rtmp://58.200.131.2:1935/livetv/cctv6")
        self.playerView.prepareToPlay()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

