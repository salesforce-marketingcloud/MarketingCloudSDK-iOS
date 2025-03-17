//
//  NotificationViewController.swift
//  MarketingCloudContentExtension
//
//  Created by Himadri Sekhar Jyoti on 24/02/25.
//  Copyright © 2025 Salesforce. All rights reserved.
//


import MCExtensionSDK

class NotificationViewController: SFMCNotificationViewController { 
    override func sfmcProvideConfig() -> SFContentExtensionConfig {
        var logLevel: LogLevel = .none
#if DEBUG
        logLevel = .debug
#endif
        return SFContentExtensionConfig(logLevel: logLevel, timeoutIntervalForRequest: 30.0)
    }
}
