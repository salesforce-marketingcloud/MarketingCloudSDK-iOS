//
//  MarketingCloudSDKEventRegionObject.h
//  JB4A-SDK-iOS
//
//  Copyright © 2017 Salesforce. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 MarketingCloudSDKEventRegionObject is a representation of a physical region that should trigger a message to be presented to the user. This could be either macro, a geofence, or micro, an iBeacon (marketing name: Proximity), but both go through iOS' Location Manager, and are reported back to the SDK through the CLLocationManagerDelegate (which within MarketingCloudSDK).
 
 Geofences will have a latitude and longitude and radius, but will be notably absent of a proximity UUID, major and minor number. Beacons also have latitude and longitude (but no radius) because of a decision to track their physical location in the world, but it is inconsequential to functionality. A beacon is functional because of the Proximity UUID. Major and Minor number. The three of these uniquely identify a physical beacon. Per Apple's best practices (WWDC 2013), a single UUID should be used commonly amongst an entire Enterprise (example: All Starbucks locations share a UUID). Major numbers should designate a single location within the UUID (Motes Coffee Shop #1234, 15th and College, Indianapolis), and a Minor number can indicate the beacon within the location designated in the Major (Point of Sale). Salesforce suggests following this pattern when configuring beacons.
 */

@interface MarketingCloudSDKEventRegionObject : NSObject

/**
 Marketing Cloud-generated identifier for the MarketingCloudSDKEventRegionObject in question. This should be treated as a primary key, and is stored on the device as the encoded version sent via the routes.
 */
@property (nonatomic, readonly, copy, nullable) NSString *fenceIdentifier;

/**
 The latitude of this region. Saved in an NSNumber as a double for easy passing. Be sure to call doubleValue on this property.
 */
@property (nonatomic, readonly, copy, nullable) NSNumber *latitude;

/**
 The longitude of this region. Saved in an NSNumber as a double for easy passing. Be sure to call doubleValue on this property.
 */
@property (nonatomic, readonly, copy, nullable) NSNumber *longitude;

/**
 For geofences only, the radius of the fence. This number, an integer, is in meters.
 */
@property (nonatomic, readonly, copy, nullable) NSNumber *radius;

/**
 For beacons, the Proximity UUID of the beacon.
 */
@property (nonatomic, readonly, copy, nullable) NSString *proximityUUID;

/**
 For beacons, the Major number. This is a uint32 per the CLBeaconRegion spec.
 */
@property (nonatomic, readonly, copy, nullable) NSNumber *majorNumber;

/**
 For beacons, the Minor number. This is a uint32 per the CLBeaconRegion spec.
 */
@property (nonatomic, readonly, copy, nullable) NSNumber *minorNumber;

/**
 This is the name which is set on SalesforceMarketingCloud, while setting the region.
 */
@property (nonatomic, readonly, copy, nullable) NSString *regionName;

/**
 Helper to quickly determine if this is a Geofence region.
 
 @return YES or NO if a geofence.
 */
@property (nonatomic, readonly) BOOL isGeofenceRegion;

/**
 Helper to quickly determine if this is a Beacon/Proximity region.
 
 @return YES or NO if a geofence.
 */
@property (nonatomic, readonly) BOOL isBeaconRegion;

/**
 An array of event messages associated with this region.
 */
@property (nonatomic, readonly, copy, nullable) NSArray *messages;

@end
