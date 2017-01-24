//
//  MarketingCloudSDK+LandingPageWebView.h
//  JB4A-SDK-iOS
//
//  Copyright © 2017 Salesforce. All rights reserved.
//

#import "MarketingCloudSDK.h"
#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>


@interface MarketingCloudSDK (LandingPageWebView)

/**
 This is a helper class that shows webpages. These come down in several forms - sometimes a CloudPage, sometimes something from OpenDirect - and this view can show them. It's a pretty simple class that pops up a view with a toolbar, shows a webpage, and waits to be dismissed.
 
 This class encapuslates a WKWebView.
 
 To use, create an instance of this UIViewController and present it from the application's parent view controller.
 */

/**
 A helper designated initializer that takes the landing page as a string.
 
 @param landingPage A NSString value
 @return Returns a UIViewController representing the SDK's controller for the webview.
 */
-(UIViewController * _Nullable)landingPageWithString:(NSString * _Nonnull)landingPage;

/**
 Another helper that takes it in NSURL form. We're not picky. It'd be cool of ObjC did method overloading, though.
 
 @param landingPage A NSURL value
 @return Returns a UIViewController representing the SDK's controller for the webview.
 */
-(UIViewController * _Nullable)landingPageWithURL:(NSURL * _Nonnull)landingPage;

@end

