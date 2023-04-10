//
//  SFMCEndpointConfigurationEntity+CoreDataProperties.h
//  
//
//  Created by iosadmin on 4/4/23.
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
