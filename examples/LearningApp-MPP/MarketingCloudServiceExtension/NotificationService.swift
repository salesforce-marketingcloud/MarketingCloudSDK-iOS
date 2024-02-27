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
