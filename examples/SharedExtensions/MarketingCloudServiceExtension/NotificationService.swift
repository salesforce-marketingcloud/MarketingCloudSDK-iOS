import CoreGraphics
import UserNotifications
import MCExtensionSDK
import UniformTypeIdentifiers

class NotificationService: SFMCNotificationService {
    static let mediaUrlKey = "_mediaUrl"
    static let altTextKey = "_mediaAlt"
    static let defaultMediaExtension = ".jpg"
    
    // Please use this method to enable logging, change logging levels etc, if required
    override func sfmcProvideConfig() -> SFNotificationServiceConfig {
        var logLevel: LogLevel = .none
#if DEBUG
        logLevel = .debug
#endif
        return SFNotificationServiceConfig(logLevel: logLevel)
    }

    override func sfmcDidReceive(_ request: UNNotificationRequest,
                                 mutableContent: UNMutableNotificationContent,
                                 withContentHandler contentHandler: @escaping ([AnyHashable: Any]?) -> Void) {
        if let mediaUrlString = mutableContent.userInfo[NotificationService.mediaUrlKey] as? String {
            self.downloadMediaAndSetAttachment(for: mediaUrlString, mutableContent: mutableContent) { [weak self] isAttachmentAddSuccess in
                if !isAttachmentAddSuccess {
                    self?.setAltText(for: mutableContent)
                }
                
                contentHandler(nil)
            }
        } else {
            // No media URL found in the payload
            contentHandler(nil)
        }
    }
    
    func downloadMediaAndSetAttachment(for mediaUrlValue: String, mutableContent: UNMutableNotificationContent, completionHandler: @escaping (_ isAttachSuccess: Bool) -> Void) {
        guard let mediaUrl = URL(string: mediaUrlValue) else {
            completionHandler(false)
            return
        }
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        session.downloadTask(with: mediaUrl) { [weak self] location, response, error in
            self?.handleDownloadTaskResponse(mutableContent: mutableContent, location: location, response: response, error: error, completionHandler: completionHandler)
        }.resume()
    }
    
    func handleDownloadTaskResponse(mutableContent: UNMutableNotificationContent, location: URL?, response: URLResponse?, error: Error?, completionHandler: @escaping (_ isAttachSuccess: Bool) -> Void) {
        guard let downloadResponse = response as? HTTPURLResponse,
                (downloadResponse.statusCode >= 200 && downloadResponse.statusCode <= 299),
                let validLocation = location else {
            completionHandler(false)
            return
        }
        
        let bestGuessFileExension = self.fileExtension(from: downloadResponse.mimeType)
        let localMediaUrl = URL.init(fileURLWithPath: validLocation.path + bestGuessFileExension)
        try? FileManager.default.removeItem(at: localMediaUrl)
        
        guard let _ = try? FileManager.default.moveItem(at: validLocation, to: localMediaUrl) else {
            completionHandler(false)
            return
        }
        
        guard let mediaAttachment = self.createMediaAttachment(localMediaUrl) else {
            completionHandler(false)
            return
        }
        
        mutableContent.attachments = [mediaAttachment]
        completionHandler(true)
    }
    
    func createMediaAttachment(_ localMediaUrl: URL) -> UNNotificationAttachment? {
        let clipRect = CGRectZero
        let mediaAttachment = try? UNNotificationAttachment(identifier: "attachmentIdentifier",
                                                            url: localMediaUrl,
                                                            options: [UNNotificationAttachmentOptionsThumbnailHiddenKey: false,
                                                                UNNotificationAttachmentOptionsThumbnailClippingRectKey: clipRect.dictionaryRepresentation])
        return mediaAttachment
    }
    
    func fileExtension(from mimeTypeValue: String?) -> String {
        var fileExtension = NotificationService.defaultMediaExtension
        
        guard let mimeType = mimeTypeValue else {
            return fileExtension
        }
        
        if #available(iOS 14.0, *) {
            guard let type = UTType(mimeType: mimeType), let ext = type.preferredFilenameExtension else {
                return fileExtension
            }
            fileExtension = "." + ext
        }
        return fileExtension
    }
    
    func setAltText(for mutableContent: UNMutableNotificationContent) {
        guard let mediaAltText = mutableContent.userInfo[NotificationService.altTextKey] as? String, !mediaAltText.isEmpty else {
            return
        }
        
        mutableContent.body = mediaAltText
    }
}
