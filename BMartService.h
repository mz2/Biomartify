//
//  BMartService.h
//  Biomartify
//
//  Created by Matias Piipari on 07/05/2010.
//  Copyright 2010 Wellcome Trust Sanger Institute. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class BMRegistry;
@class BMart;
@class BMDataset;

/*
@protocol BMartServiceDelegate <NSObject>

-(void) registryReceived:(BMRegistry*)registry;
-(void) registryRequestFailed:(NSError*)error;

-(void) datasetsReceived:(NSArray*)datasets forMart:(BMart*) mart;
-(void) datasetRequestFailed:(NSError*)error;

-(void) attributesReceived:(NSArray*)attributes forDataset:(BMDataset*) dataset;
-(void) attributeRequestFailed:(NSError*)error;

-(void) filtersReceived:(NSArray*)attributes forMart:(BMDataset*) dataset;
-(void) filterRequestFailed:(NSError*)error;

@end
 */

@interface BMartService : NSObject {
	//NSString *_baseURL;
	//id<BMartServiceDelegate> _delegate;
	
	BMRegistry *_cachedRegistry;
	NSMutableDictionary *_cachedDatasets;
}

@property(nonatomic,copy)NSString *baseURL;
@property(nonatomic,retain)BMRegistry *cachedRegistry;

-(void) requestRegistryForMartServiceAtURL:(NSURL*)url;
-(void) requestDatasetsForMart:(BMart*)mart;
-(void) requestAttributesForDataset:(BMDataset*)dataset;
-(void) requestFiltersForDataset:(BMDataset*)dataset;

+(NSURL*) martRegistryURL;

+ (id)sharedMartService; //singleton instance

@end
