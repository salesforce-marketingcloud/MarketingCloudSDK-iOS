//
//  SFMCConfigurationEntity+CoreDataProperties.h
//  
//
//  Created by Ethan Yehuda on 1/19/23.
//
//  This file was automatically generated and should not be edited.
//

#import "SFMCConfigurationEntity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface SFMCConfigurationEntity (CoreDataProperties)

+ (NSFetchRequest<SFMCConfigurationEntity *> *)fetchRequest NS_SWIFT_NAME(fetchRequest());

@property (nonatomic) int16_t messagesGatingTimeoutMs;
@property (nonatomic) int16_t messagesPerSecond;
@property (nonatomic) int16_t messagesPerSession;

@end

NS_ASSUME_NONNULL_END
