//
//  SFMCEndpointConfigurationEntity+CoreDataProperties.h
//  
//
//  Created by Ethan Yehuda on 9/29/22.
//
//  This file was automatically generated and should not be edited.
//

#import "SFMCEndpointConfigurationEntity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface SFMCEndpointConfigurationEntity (CoreDataProperties)

+ (NSFetchRequest<SFMCEndpointConfigurationEntity *> *)fetchRequest NS_SWIFT_NAME(fetchRequest());

@property (nullable, nonatomic, copy) NSString *dataType;
@property (nonatomic) int16_t maxBatchSize;
@property (nullable, nonatomic, copy) NSString *path;

@end

NS_ASSUME_NONNULL_END
