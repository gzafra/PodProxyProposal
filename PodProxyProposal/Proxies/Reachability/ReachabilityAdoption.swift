//
//  ReachabilityAdoption.swift
//  PodProxyProposal
//
//  Created by Guillermo Zafra on 07/12/2018.
//  Copyright © 2018 Guillermo Zafra. All rights reserved.
//

import Foundation
import FXReachability
import Reachability

// MARK: -

extension ReachabilityProxy {
    convenience init() {
        self.init(with: FXReachability())
    }
}

// MARK: - Adoption of ReachabilityProtocol by ReachabilitySwift framework

//extension Reachability: ReachabilityProtocol {
//    func startNotifications() {
//        try? startNotifier()
//    }
//
//    var isConnected: Bool {
//        return self.connection != .none
//    }
//
//    var connectionStatus: ReachabilityConnectionStatus {
//        switch self.connection {
//        case .none:
//            return ReachabilityConnectionStatus.none
//        case .cellular:
//            return ReachabilityConnectionStatus.cellular
//        case .wifi:
//            return ReachabilityConnectionStatus.wifi
//        }
//    }
//}

// MARK: - Adoption of ReachabilityProtocol by ReachabilitySwift framework

extension FXReachability: ReachabilityProtocol {
    func startNotifications() {}
    
    var isConnected: Bool {
        return self.isReachable
    }
    
    var connectionStatus: ReachabilityConnectionStatus {
        switch self.status {
        case .notReachable, .unknown:
            return ReachabilityConnectionStatus.none
        case .reachableViaWWAN:
            return ReachabilityConnectionStatus.cellular
        case .reachableViaWiFi:
            return ReachabilityConnectionStatus.wifi
        }
    }
}
