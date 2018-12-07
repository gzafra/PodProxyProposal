//
//  ReachabilityProxy.swift
//  PodProxyProposal
//
//  Created by Guillermo Zafra on 07/12/2018.
//  Copyright © 2018 Guillermo Zafra. All rights reserved.
//

import Foundation

enum ReachabilityConnectionStatus {
    case none, wifi, cellular
}

// MARK: - Our generic reachability proxy
class ReachabilityProxy {
    private let reachability: ReachabilityProtocol
    
    init(with reachability: ReachabilityProtocol) {
        self.reachability = reachability
    }

    var connectionStatus: ReachabilityConnectionStatus {
        return reachability.connectionStatus
    }
    
    var isConnected: Bool {
        return reachability.isConnected
    }
    
    
    public func setup() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reachabilityChanged(note:)),
                                               name: .reachabilityChangedNotification, object: reachability)
        reachability.startNotifications()
    }
    
    // MARK: - Notifications
    @objc private func reachabilityChanged(note: Notification) {
        NotificationCenter.default.post(name: ReachabilityProxy.reachabilityChangedNotification, object: nil) // Forward
    }
    
    @objc static var reachabilityChangedNotification: Notification.Name {
        return Notification.Name(rawValue: "ReachabilityProxy.reachabilityChanged")
    }
}

public extension Notification.Name {
    public static let reachabilityChangedNotification = Notification.Name("reachabilityChanged")
}

// MARK: - Protocol our chosen framework will have to adopt
protocol ReachabilityProtocol {
    var isConnected: Bool { get }
    var connectionStatus: ReachabilityConnectionStatus { get }
    func startNotifications()
}
