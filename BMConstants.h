//
//  BMConstants.h
//  biomartify
//
//  Created by Matias Piipari on 07/05/2010.
//  Copyright 2010 Wellcome Trust Sanger Institute. All rights reserved.
//

#import <Cocoa/Cocoa.h>

extern NSString * const BMRegistryURLDefault;
extern NSString * const BMRegistryURLKey;

extern NSString * const BMMartURLDefault;
extern NSString * const BMCurrentMartURLKey;

extern NSString * const BMRegistryReceivedNotification;
extern NSString * const BMRegistryRequestFailedNotification;

extern NSString * const BMartReceivedDatasetsForMartNotification;
extern NSString * const BMartRequestDatasetsForMartFailedNotification;

extern NSString * const BMartReceivedAttributesForDatasetNotification;
extern NSString * const BMartRequestAttributesForDatasetFailedNotification;

extern NSString * const BMartReceivedFiltersForDatasetNotification;
extern NSString * const BMartRequestFiltersForDatasetFailedNotification;

extern NSString * const BMartReceivedDatasetConfigurationForDataset;
extern NSString * const BMartRequestDatasetConfigurationForMartFailedNotification;