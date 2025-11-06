//
//  ToggleCell.swift
//  LearningApp
//
//  Copyright © 2025 Salesforce. All rights reserved.
//

import UIKit
import SFMCSDK
import MarketingCloudSDK
import MobileAppMessagingSDK

class ToggleCell: UITableViewCell {
    
    enum ToggleType {
        case analytics
        case mobileAppMessagingAnalytics
        case piAnalytics
        case location
        case inbox
        case locationWatching
    }
    
    private var toggleAction: ((Bool) -> Void)?
    
    private let toggle: UISwitch = {
        let toggle = UISwitch()
        return toggle
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        accessoryView = toggle
        selectionStyle = .none
        toggle.addTarget(self, action: #selector(toggleChanged), for: .valueChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // Reset cell state for reuse
        textLabel?.text = nil
        textLabel?.alpha = 1.0
        toggle.isOn = false
        toggle.isEnabled = true
        toggleAction = nil
        backgroundColor = nil
        contentView.backgroundColor = nil
    }
    
    // MARK: - Configuration Methods
    
    /// Configures cell for runtime toggles (Analytics, MAM Analytics, PI Analytics, Location, Inbox)
    func configureForRuntimeToggle(type: ToggleType, title: String) {
        textLabel?.text = title
        fetchInitialState(for: type)
        toggleAction = { [weak self] enabled in
            self?.handleToggleChange(for: type, enabled: enabled)
        }
    }
    
    /// Configures cell for location watching toggle in SDK Features section
    func configureForLocationWatching(onToggle: @escaping (Bool) -> Void) {
        textLabel?.text = "Enable Location Watching"
        
        MarketingCloudSdk.requestSdk { [weak self] mp in
            let isLocationEnabled = mp?.isLocationEnabled() ?? false
            let isWatching = mp?.watchingLocation() ?? false
            
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                self.toggle.isOn = isWatching
                self.toggle.isEnabled = isLocationEnabled
                self.textLabel?.alpha = isLocationEnabled ? 1.0 : 0.5
                self.toggleAction = onToggle
            }
        }
    }
    
    // MARK: - Private Helpers
    
    private func fetchInitialState(for type: ToggleType) {
        switch type {
        case .analytics:
            MarketingCloudSdk.requestSdk { [weak self] mp in
                let isOn = mp?.isAnalyticsEnabled() ?? false
                self?.updateToggle(isOn: isOn)
            }
            
        case .mobileAppMessagingAnalytics:
            MobileAppMessaging.requestSdk { [weak self] mam in
                let isOn = mam?.isAnalyticsEnabled() ?? false
                self?.updateToggle(isOn: isOn)
            }
            
        case .piAnalytics:
            MarketingCloudSdk.requestSdk { [weak self] mp in
                let isOn = mp?.isPiAnalyticsEnabled() ?? false
                self?.updateToggle(isOn: isOn)
            }
            
        case .location:
            MarketingCloudSdk.requestSdk { [weak self] mp in
                let isOn = mp?.isLocationEnabled() ?? false
                self?.updateToggle(isOn: isOn)
            }
            
        case .inbox:
            MarketingCloudSdk.requestSdk { [weak self] mp in
                let isOn = mp?.isInboxEnabled() ?? false
                self?.updateToggle(isOn: isOn)
            }
            
        case .locationWatching:
            break
        }
    }
    
    private func handleToggleChange(for type: ToggleType, enabled: Bool) {
        switch type {
        case .analytics:
            MarketingCloudSdk.requestSdk { mp in
                mp?.setAnalyticsEnabled(enabled)
            }
            
        case .mobileAppMessagingAnalytics:
            MobileAppMessaging.requestSdk { mam in
                mam?.setAnalyticsEnabled(enabled)
            }
            
        case .piAnalytics:
            MarketingCloudSdk.requestSdk { mp in
                mp?.setPiAnalyticsEnabled(enabled)
            }
            
        case .location:
            MarketingCloudSdk.requestSdk { mp in
                mp?.setLocationEnabled(enabled)
            }
            NotificationCenter.default.post(
                name: .locationFeatureToggled,
                object: nil,
                userInfo: ["enabled": enabled]
            )
            
        case .inbox:
            MarketingCloudSdk.requestSdk { mp in
                mp?.setInboxEnabled(enabled)
            }
            
        case .locationWatching:
            break
        }
    }
    
    private func updateToggle(isOn: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.toggle.isOn = isOn
        }
    }
    
    @objc private func toggleChanged() {
        toggleAction?(toggle.isOn)
    }
}
