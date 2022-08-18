### ReadMe.md

### Configure for development and testing in AppDelegate.swift

```
	let appID = "e58c6fcf-b50e-4204-8bae-6967bae907fe"
    let accessToken = "wjsenz99hfbeqgd7fugt6zj3"
    let appEndpoint = URL(string: "https://mcgrjfgk81ckrt0h4rwlnbhmbvf4.device.marketingcloudapis.com/")!
    let mid = "1234"
```

### Swift Packages

```
Add following Swift Packages to the LearningApp:
SFMCSDK https://github.com/salesforce-marketingcloud/sfmc-sdk-ios >= 1.0.0
MobilePush https://github.com/salesforce-marketingcloud/MarketingCloudSDK-iOS/tree/spm >= 8.0.0


Swift Packages are downloaded upon build.
To manually resolve go to File > Swift Packages > Resolve Package Versions

Once packages are included, manually pull in the MarketingCloudSDK.bundle from the MarketingCloudSDK/Sources/MarketingCloudSDKResources folder located in the MarketingCloudSDK Swift Package and link it with the binary in the build phase.

```

### Open the `.xcworkspace` file
