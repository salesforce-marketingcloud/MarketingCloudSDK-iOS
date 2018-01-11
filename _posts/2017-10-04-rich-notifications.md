---
layout: page
title: "Rich Notifications"
subtitle: "Send Rich Notifications"
category: push-notifications
date: 2017-10-04 12:00:00
order: 4
---

## Prerequisites

* Make sure that your iOS app is built for iOS 10 or 11.
* Include a service extension for your app that can handle mutable content. See [Apple’s documentation](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/ModifyingNotifications.html).
* Update to version 4.9.6 or higher of the Journey Builder for Apps (JB4A) SDK, which supports iOS 10.
* Make sure that your app is registered for push notifications via the MarketingCloudSDK.

Rich notifications include images, videos, titles and subtitles from the MobilePush app, and mutable content. Mutable content can include personalization in the title, subtitle, or body of your message. Use Xcode 9 from Apple to create a Notification Service Extension in your application project.

1. Click **File**.
1. Click **New**.
1. Click **Target**.
1. Select Notification Service Extension.
1. Name and save the new extension.

> Note: Notification Target must be signed by the same XCode Managed Profile as the main project.

## Service Extension Example in Objective C

This service extension checks for a "&#95;mediaUrl" element in request.content.userInfo.  If found, the extension attempts to download the media from the URL , creates a thumbnail-size version, and then adds the attachment. The service extension also checks for a ""&#95;mediaAlt" element in request.content.userInfo.  If found, the service extension uses the element for the body text if there are any problems downloading or creating the media attachment.

A service extension can timeout when it is unable to download.  In this code sample, the service extension delivers the original content with the body text changed to the value in "&#95;mediaAlt".

```
/*
 * Copyright (c) 2017, salesforce.com, inc.
 * All rights reserved.
 * Licensed under the BSD 3-Clause license.
 * For full license text, see LICENSE.txt file in the repo root  or https://opensource.org/licenses/BSD-3-Clause
 */

#import "NotificationService.h"
#import <CoreGraphics/CoreGraphics.h>

@interface NotificationService ()

@property (nonatomic, strong) void (^contentHandler)(UNNotificationContent *contentToDeliver);
@property (nonatomic, strong) UNMutableNotificationContent *modifiedNotificationContent;

@end

@implementation NotificationService

- (UNNotificationAttachment *)createMediaAttachment:(NSURL *)localMediaUrl {
    // options: specify what cropping rectangle of the media to use for a thumbnail
    //          whether the thumbnail is hidden or not
    UNNotificationAttachment *mediaAttachment = [UNNotificationAttachment attachmentWithIdentifier: @"attachmentIdentifier"
                                                                                               URL: localMediaUrl
                                                                                           options: @{
                                                                                                      UNNotificationAttachmentOptionsThumbnailClippingRectKey: (NSDictionary *)CFBridgingRelease(CGRectCreateDictionaryRepresentation(CGRectZero)),
                                                                                                      UNNotificationAttachmentOptionsThumbnailHiddenKey: @NO}
                                                                                             error: nil];
    return mediaAttachment;
}

- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {

    // save the completion handler we will call back later
    self.contentHandler = contentHandler;

    // make a copy of the notification so we can change it
    self.modifiedNotificationContent = [request.content mutableCopy];

    // alternative text to display if there are any issues loading the media URL
    NSString *mediaAltText = request.content.userInfo[@"_mediaAlt"];

    // does the payload contains a remote URL to download or a local URL?
    NSString *mediaUrlString = request.content.userInfo[@"_mediaUrl"];
    NSURL *mediaUrl = [NSURL URLWithString: mediaUrlString];

    // if we have a URL, try to download media (i.e., https://media.giphy.com/media/3oz8xJBbCpzG9byZmU/giphy.gif)
    if (mediaUrl != nil) {
        // create a session to handle downloading of the URL
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];

        // start a download task to handle the download of the media
        __weak __typeof__(self) weakSelf = self;
        [[session downloadTaskWithURL:mediaUrl completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            BOOL useAlternateText = YES;

            // if the download succeeded, save it locally and then make an attachment
            if (error == nil) {
                if (200 <= ((NSHTTPURLResponse*)response).statusCode  && ((NSHTTPURLResponse*)response).statusCode <= 299) {
                    // download was successful, attempt save the media file
                    NSURL *localMediaUrl = [NSURL fileURLWithPath:[location.path stringByAppendingString:mediaUrl.lastPathComponent]];

                    // remove any existing file with the same name
                    [[NSFileManager defaultManager] removeItemAtURL:localMediaUrl error:nil];

                    // move the downloaded file from the temporary location to a new file
                    if ([[NSFileManager defaultManager] moveItemAtURL:location toURL:localMediaUrl error:nil] == YES) {
                        // create an attachment with the new file
                        UNNotificationAttachment * mediaAttachment = [weakSelf createMediaAttachment:localMediaUrl];

                        // if no problems creating the attachment, we can use it
                        if (mediaAttachment != nil) {
                            // set the media to display in the notification
                            weakSelf.modifiedNotificationContent.attachments = @[mediaAttachment];

                            // everything is ok
                            useAlternateText = NO;
                        }
                    }
                }
            }

            // if any problems creating the attachment, use the alternate text if provided
            if ((useAlternateText == YES) && (mediaAltText != nil)) {
                weakSelf.modifiedNotificationContent.body = mediaAltText;
            }

            // tell the OS we are done and here is the new content
            weakSelf.contentHandler(weakSelf.modifiedNotificationContent);
        }] resume];
    }
    else {
        // see if the media URL is for a local file  (i.e., file://movie.mp4)
        BOOL useAlternateText = YES;
        if (mediaUrlString != nil) {
            // attempt to create a URL to a file in local storage
            NSURL *localMediaUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource: mediaUrlString.lastPathComponent.stringByDeletingLastPathComponent ofType:mediaUrlString.pathExtension]];

            // is the URL a local file URL?
            if (localMediaUrl != nil && localMediaUrl.isFileURL == YES) {
                // create an attachment with the local media
                UNNotificationAttachment * mediaAttachment = [self createMediaAttachment:localMediaUrl];

                // if no problems creating the attachment, we can use it
                if (mediaAttachment != nil) {
                    // set the media to display in the notification
                    self.modifiedNotificationContent.attachments = @[mediaAttachment];

                    // everything is ok
                    useAlternateText = NO;
                }
            }
        }

        // if any problems creating the attachment, use the alternate text if provided
        if ((useAlternateText == YES) && (mediaAltText != nil)) {
            self.modifiedNotificationContent.body = mediaAltText;
        }

        // tell the OS we are done and here is the new content
        contentHandler(self.modifiedNotificationContent);
    }
}

- (void)serviceExtensionTimeWillExpire {
    // Called just before the extension will be terminated by the system.
    // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.

    // we took too long to download the media URL, use the alternate text if provided
    NSString *mediaAltText = self.modifiedNotificationContent.userInfo[@"_mediaAlt"];
    if (mediaAltText != nil) {
        self.modifiedNotificationContent.body = mediaAltText;
    }

    // tell the OS we are done and here is the new content
    self.contentHandler(self.modifiedNotificationContent);
}

@end
```

## Service Extension Example in Swift

```
/*
 * Copyright (c) 2017, salesforce.com, inc.
 * All rights reserved.
 * Licensed under the BSD 3-Clause license.
 * For full license text, see LICENSE.txt file in the repo root  or https://opensource.org/licenses/BSD-3-Clause
 */

import CoreGraphics
import UserNotifications

class NotificationService: UNNotificationServiceExtension {
    var contentHandler: ((_ contentToDeliver: UNNotificationContent) -> Void)? = nil
    var modifiedNotificationContent: UNMutableNotificationContent?

    func createMediaAttachment(_ localMediaUrl: URL) -> UNNotificationAttachment {
        // options: specify what cropping rectangle of the media to use for a thumbnail
        //          whether the thumbnail is hidden or not
        let clippingRect = CGRect.zero
        let mediaAttachment = try? UNNotificationAttachment(identifier: "attachmentIdentifier", url: localMediaUrl, options: [UNNotificationAttachmentOptionsThumbnailClippingRectKey: clippingRect.dictionaryRepresentation, UNNotificationAttachmentOptionsThumbnailHiddenKey: false])
        return mediaAttachment!
    }

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {

        // save the completion handler we will call back later
        self.contentHandler = contentHandler

        // make a copy of the notification so we can change it
        modifiedNotificationContent = (request.content.mutableCopy() as? UNMutableNotificationContent)

        // does the payload contains a remote URL to download or a local URL?
        if let mediaUrlString = request.content.userInfo["_mediaUrl"] as? String {
            // see if the media URL is for a local file  (i.e., file://movie.mp4)
            guard let mediaUrl = URL(string: mediaUrlString) else {
                // attempt to create a URL to a file in local storage
                var useAlternateText: Bool = true
                if mediaUrlString.isEmpty == false {
                    let mediaUrlFilename:NSString = mediaUrlString as NSString
                    let fileName = (mediaUrlFilename.lastPathComponent as NSString).deletingPathExtension
                    let fileExtension = (mediaUrlFilename.lastPathComponent as NSString).pathExtension

                    // is it in the bundle?
                    if let localMediaUrlPath = Bundle.main.path(forResource: fileName, ofType: fileExtension) {
                        // is the URL a local file URL?
                        let localMediaUrl = URL.init(fileURLWithPath: localMediaUrlPath)
                        if localMediaUrl.isFileURL == true {
                            // create an attachment with the local media
                            let mediaAttachment: UNNotificationAttachment? = createMediaAttachment(localMediaUrl)

                            // if no problems creating the attachment, we can use it
                            if mediaAttachment != nil {
                                // set the media to display in the notification
                                modifiedNotificationContent?.attachments = [mediaAttachment!]

                                // everything is ok
                                useAlternateText = false
                            }
                        }
                    }
                }

                // if any problems creating the attachment, use the alternate text if provided
                if (useAlternateText == true) {
                    if let mediaAltText = request.content.userInfo["_mediaAlt"] as? String {
                        if mediaAltText.isEmpty == false {
                            modifiedNotificationContent?.body = mediaAltText
                        }
                    }
                }

                // tell the OS we are done and here is the new content
                contentHandler(modifiedNotificationContent!)
                return
            }

            // if we have a URL, try to download media (i.e., https://media.giphy.com/media/3oz8xJBbCpzG9byZmU/giphy.gif)
            if mediaUrl.isFileURL == false {
                // create a session to handle downloading of the URL
                let session = URLSession(configuration: URLSessionConfiguration.default)

                // start a download task to handle the download of the media
                weak var weakSelf: NotificationService? = self
                session.downloadTask(with: mediaUrl, completionHandler: {(_ location: URL?, _ response: URLResponse?, _ error: Error?) -> Void in
                    var useAlternateText: Bool = true
                    // if the download succeeded, save it locally and then make an attachment
                    if error == nil {
                        let downloadResponse = response as! HTTPURLResponse
                        if (downloadResponse.statusCode >= 200 && downloadResponse.statusCode <= 299) {
                            // download was successful, attempt save the media file
                            let localMediaUrl = URL.init(fileURLWithPath: location!.path + mediaUrl.lastPathComponent)

                            // remove any existing file with the same name
                            try? FileManager.default.removeItem(at: localMediaUrl)

                            // move the downloaded file from the temporary location to a new file
                            if ((try? FileManager.default.moveItem(at: location!, to: localMediaUrl)) != nil) {
                                // create an attachment with the new file
                                let mediaAttachment: UNNotificationAttachment? = weakSelf?.createMediaAttachment(localMediaUrl)

                                // if no problems creating the attachment, we can use it
                                if mediaAttachment != nil {
                                    // set the media to display in the notification
                                    weakSelf?.modifiedNotificationContent?.attachments = [mediaAttachment!]

                                    // everything is ok
                                    useAlternateText = false
                                }
                            }
                        }
                    }

                    // if any problems creating the attachment, use the alternate text if provided
                    // alternative text to display if there are any issues loading the media URL
                    if (useAlternateText == true) {
                        if let mediaAltText = request.content.userInfo["_mediaAlt"] as? String {
                            if mediaAltText.isEmpty == false {
                                weakSelf?.modifiedNotificationContent?.body = mediaAltText
                            }
                        }
                    }

                    // tell the OS we are done and here is the new content
                    weakSelf?.contentHandler!((weakSelf?.modifiedNotificationContent)!)
                }).resume()
            }
        }
        else {
            // no media URL found in the payload, just pass on the orginal payload
            contentHandler(request.content)
            return
        }
    }

    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        // we took too long to download the media URL, use the alternate text if provided

        if let mediaAltText = modifiedNotificationContent?.userInfo["_mediaAlt"] as? String {
            // alternative text to display if there are any issues loading the media URL
            if mediaAltText.isEmpty == false {
                modifiedNotificationContent?.body = mediaAltText
            }
        }

        // tell the OS we are done and here is the new content
        contentHandler!(modifiedNotificationContent!)
    }
}
```
