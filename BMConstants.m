//
//  BMConstants.m
//  biomartify
//
//  Created by Matias Piipari on 07/05/2010.
//  Copyright 2010 Wellcome Trust Sanger Institute. All rights reserved.
//

#import "BMConstants.h"

NSString * const BMRegistryURLDefault = @"http://www.biomart.org/biomart/martservice?type=registry";
NSString * const BMRegistryURLKey = @"BMRegistryURL";

NSString * const BMMartURLDefault = @"http://www.biomart.org/biomart/martservice";
NSString * const BMCurrentMartURLKey = @"BMServiceBaseURL";

NSString * const BMRegistryReceivedNotification = @"BMRegistryReceived";
NSString * const BMRegistryRequestFailedNotification = @"BMRegistryRequestFailed";

NSString * const BMartReceivedDatasetsForMartNotification = @"BMRequestDatasetsForMart";
NSString * const BMartRequestDatasetsForMartFailedNotification = @"BMRequestDatasetsForMartFailed";

NSString * const BMartReceivedAttributesForDatasetNotification = @"BMReceivedAttributesForDataset";
NSString * const BMartRequestAttributesForDatasetFailedNotification = @"BMRequestAttributesFordatasetFailed";

NSString * const BMartReceivedFiltersForDatasetNotification = @"BMReceivedFiltersForDataset";
NSString * const BMartRequestFiltersForDatasetFailedNotification = @"BMRequestFiltersFordatasetFailed";