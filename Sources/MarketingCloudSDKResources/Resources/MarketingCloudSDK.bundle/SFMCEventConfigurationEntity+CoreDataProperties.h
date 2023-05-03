//
//  SFMCEventConfigurationEntity+CoreDataProperties.h
//  
//
//  Created by iosadmin on 5/1/23.
//
//  This file was automatically generated and should not be edited.
//

#import "SFMCEventConfigurationEntity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface SFMCEventConfigurationEntity (CoreDataProperties)

+ (NSFetchRequest<SFMCEventConfigurationEntity *> *)fetchRequest NS_SWIFT_NAME(fetchRequest());

@property (nullable, nonatomic, copy) NSString *activeEvents;
@property (nonatomic) BOOL enableAppEvents;
@property (nonatomic) BOOL enableDebugInfo;
@property (nonatomic) BOOL enableEngagementEvents;
@property (nonatomic) BOOL enableIdentityEvents;
@property (nonatomic) BOOL enableSystemEvents;
@property (nonatomic) BOOL enableTelemetryInfo;

@end

NS_ASSUME_NONNULL_END
