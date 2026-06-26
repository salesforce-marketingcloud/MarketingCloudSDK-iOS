import MCExtensionSDK

class NotificationService: SFMCNotificationService {
    
    // Please use this method to enable logging, change logging levels etc, if required
    override func sfmcProvideConfig() -> SFNotificationServiceConfig {
        var logLevel: LogLevel = .none
#if DEBUG
        logLevel = .debug
#endif
        return SFNotificationServiceConfig(logLevel: logLevel)
    }
    
    // Please use this method if and only if you need to do any custom processing e.g. image, video download, inserting custom keys in notification userInfo etc
    // Please don't modify  `mutableContent.request.content.userInfo` directly as doing so may result in exception
    // If you need to add any custom key in notification userInfo, then please return a dictionary in the completion handler
    
    
    // Please note that like the `UNNotificationServiceExtension` method - func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) → Void),
    // you will only get limited time from system to perform your processing operation
    override func sfmcDidReceive(_ request: UNNotificationRequest, mutableContent: UNMutableNotificationContent, withContentHandler contentHandler: @escaping ([AnyHashable : Any]?) -> Void) {
        // Your custom code here
        //...
        self.addMedia(mutableContent) {
            // In case you need to add any custom key/value pair(s) in notifications userInfo object then
            var customUserInfo: [AnyHashable : Any] = [:]
            customUserInfo["MyCustomKey"] = "MyCustomValue"
            
            // Finally call content handler to signal end of your processing operation
            //
            contentHandler(customUserInfo)
        }
    }
    
    private func addMedia(_ mutableContent: UNMutableNotificationContent, completion: @escaping () -> Void) {
        guard let mediaUrlString = mutableContent.userInfo["_mediaUrl"] as? String,
                !mediaUrlString.isEmpty  else {
            completion()
            return
        }
        
        guard let mediaUrl = URL(string: mediaUrlString) else {
            completion()
            return
        }
                
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let downloadTask = session.downloadTask(with: mediaUrl) {
            location, response, error in
            if let _ = error {
                completion()
                return
            }
            
            guard let theLocation = location else {
                completion()
                return
            }
            
            guard let theResponse = response as? HTTPURLResponse else {
                completion()
                return
            }
            
            let statusCode = theResponse.statusCode
            guard (statusCode >= 200 && statusCode <= 299) else {
                completion()
                return
            }
            
            let localMediaUrl = URL.init(fileURLWithPath: theLocation.path + mediaUrl.lastPathComponent)
            
            // remove any existing file with the same name
            try? FileManager.default.removeItem(at: localMediaUrl)
                        
            do {
                try FileManager.default.moveItem(at: theLocation, to: localMediaUrl)
            } catch {
                completion()
                return
            }
            
            guard let mediaAttachment = try? UNNotificationAttachment(identifier: "SomeAttachmentId",
                                                                      url: localMediaUrl) else {
                completion()
                return;
            }
            
            mutableContent.attachments = [mediaAttachment]
            completion()
        }
        
        downloadTask.resume()
    }
}

