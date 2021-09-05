//
//  SFMCSDK.h
//  SFMCSDK
//
//  Copyright © 2020 Salesforce Marketing Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFKeyStoreManager.h"

//! Project version number for SFMCSdk.
FOUNDATION_EXPORT double SFMCSdkVersionNumber;

//! Project version string for SFMCSdk.
FOUNDATION_EXPORT const unsigned char SFMCSdkVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <SFMCSdk/PublicHeader.h>

@protocol SFMCSdkInAppMessageEventDelegate;
@protocol SFMCSdkInboxMessagesDataSource;
@protocol SFMCSdkInboxMessagesDelegate;
@protocol SFMCSdkLocationDelegate;
@protocol SFMCSdkURLHandlingDelegate;
