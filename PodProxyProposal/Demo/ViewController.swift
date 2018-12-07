//
//  ViewController.swift
//  PodProxyProposal
//
//  Created by Guillermo Zafra on 07/12/2018.
//  Copyright © 2018 Guillermo Zafra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let reachability = ReachabilityProxy()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // NOTE: This is just to show how it would be used
        reachability.setup()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reachabilityDidChange),
                                               name: ReachabilityProxy.reachabilityChangedNotification,
                                               object: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print(reachability.isConnected ? "Connected" : "Not connected")
    }
    
    @objc func reachabilityDidChange() {
        print("Reachability: \(reachability.connectionStatus)")
    }
}

