---
layout: page
title: "MobilePush SDK Privacy Manifest"
subtitle: "Apple Privacy Manifest"
category: use-cases
date: 2024-03-05 12:00:00
order: 1
---

 Starting with iOS 17, Apple has introduced privacy manifests for SDKs to help app developers better understand how third-party SDKs use data. Apple’s privacy manifest is a file type that outlines the privacy practices of an app or its third-party SDKs. 
 
 In the manifest, you declare the types of data you collect, using specific categories provided by Apple, and the purpose for collecting the data. As of Spring 2024, any new app or app update submission that integrates a third-party SDK must include the privacy manifest for that SDK.
    
#### Required Reason API Usage

Apple lists the [required reason APIs](https://developer.apple.com/documentation/bundleresources/privacy_manifest_files/describing_use_of_required_reason_api) that have the potential to be be misused. It is mandatory for third-party SDKs, such as the Marketing Cloud SDK, to declare the APIs used so that a developer may verify they are being used for the expected reasons.

The **Marketing Cloud SDK** uses the  following Required Reason API, which is declared in the SDK’s privacy manifest.

<table style="border: 1px solid black; border-collapse: collapse; width:100% ">
    <thead style="border: 1px solid black; border-collapse: collapse;">
      <tr style="border: 1px solid black; border-collapse: collapse; ">
        <th style="border: 1px solid black; border-collapse: collapse; text-align: left; width:20%; padding: 10px;">API Type</th>
        <th style="border: 1px solid black; border-collapse: collapse; text-align: left; width:20%; padding: 10px;">Reason</th>
        <th style="border: 1px solid black; border-collapse: collapse; text-align: left; width:60%; padding: 10px;">Comments</th>
      </tr>
    </thead>
    <tbody >
        <tr style="border: 1px solid black; border-collapse: collapse;">
            <td style="border: 1px solid black; border-collapse: collapse; padding: 10px;">NSPrivacyAccessedAPICategory
            UserDefaults</td>
            <td style="border: 1px solid black; border-collapse: collapse;padding: 10px;">CA92.1 </td>
            <td style="border: 1px solid black; border-collapse: collapse; padding: 10px;">MarketingCloudSDK uses Userdefaults to persist few SDK settings related to Data migration,SDK privacy mode,  API sync retry timestamp. </td>
        </tr>
    </tbody>
  </table>
