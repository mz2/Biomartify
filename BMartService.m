//
//  BMartService.m
//  Biomartify
//
//  Created by Matias Piipari on 07/05/2010.
//  Copyright 2010 Wellcome Trust Sanger Institute. All rights reserved.
//

#import "BMartService.h"
#import "BMart.h"
#import "BMDataset.h"
#import "BMAttribute.h"
#import "BMFilter.h"
#import "BMRegistryXMLParser.h"
#import "BMDatasetTableParser.h"
#import "BMAttributeTableParser.h"
#import "BMFilterTableParser.h"
#import "ASIHTTPRequest.h"
#import "BMDatasetConfigXMLParser.h"

@implementation BMartService
//@synthesize delegate = _delegate;
@synthesize cachedRegistry = _cachedRegistry;
@synthesize URL = _URL;

//=========================================================== 
// - (id)init
//
//=========================================================== 
- (id)init
{
    if (self = [super init]) {
        [self setURL: nil];
        [self setCachedRegistry: nil];
		
		_martsByRequest = [[NSMutableDictionary alloc] init];
		_datasetsByRequest = [[NSMutableDictionary alloc] init];
		
		self.URL = [NSURL URLWithString:[[NSUserDefaults standardUserDefaults] objectForKey:BMCurrentMartURLKey]];
    }
    return self;
}


#pragma mark Singleton

static BMartService *sharedInstance = nil; 

+ (id)sharedMartService
{
    //Already set by +initialize.
    return sharedInstance;
}

+ (id)allocWithZone:(NSZone*)zone
{
    //Usually already set by +initialize.
    @synchronized(self) {
        if (sharedInstance) {
            //The caller expects to receive a new object, so implicitly retain it
            //to balance out the eventual release message.
            return [sharedInstance retain];
        } else {
            //When not already set, +initialize is our caller.
            //It's creating the shared instance, let this go through.
            return [super allocWithZone:zone];
        }
    }
}

+ (void) initialize {
    NSMutableDictionary *defaultValues = [NSMutableDictionary dictionary];
    [defaultValues setObject: BMMartURLDefault 
					  forKey: BMCurrentMartURLKey];
	
	[defaultValues setObject: BMRegistryURLDefault
					  forKey: BMRegistryURLKey];
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultValues];
	
	
    if (sharedInstance == nil)
        sharedInstance = [[self alloc] init];
}


//=========================================================== 
// dealloc
//=========================================================== 
- (void)dealloc
{
    [_URL release], _URL = nil;
    [_cachedRegistry release], _cachedRegistry = nil;
    [_cachedDatasets release], _cachedDatasets = nil;
	[_martsByRequest release], _martsByRequest = nil;
	[_datasetsByRequest release], _datasetsByRequest = nil;
    [super dealloc];
}

+(NSURL*) martRegistryURL {
	return [NSURL URLWithString: [[NSUserDefaults standardUserDefaults] objectForKey:BMRegistryURLKey]];
}

#pragma mark Requests
-(void) requestRegistryForMartServiceAtURL:(NSURL*)url {
	BMLog(@"Requesting registry for mart at URL %@", url);
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
	[request setDelegate:self];
	[request startAsynchronous];
	[request setDidFinishSelector:@selector(didReceiveRegistry:)];
	[request setDidFailSelector:@selector(didFailToReceiveRegistry:)];
}

-(void) didReceiveRegistry:(ASIHTTPRequest*) req {
	BMRegistryXMLParser *parser = [[[BMRegistryXMLParser alloc] initWithData: [req responseData]] autorelease];
	
	_cachedRegistry = [parser.registry retain];
	BMLog(@"Received registry: %@",_cachedRegistry);
	
	[[NSNotificationCenter defaultCenter]
	 postNotificationName:BMRegistryReceivedNotification object:_cachedRegistry];
}

-(void) didFailToReceiveRegistry:(ASIHTTPRequest*) req {
	BMLog(@"Failed to receive registry: %@", [req.error localizedDescription]);
	
	[[NSNotificationCenter defaultCenter]
	 postNotificationName:BMRegistryRequestFailedNotification object: req.error];
}

-(void) requestDatasetsForMart:(BMart*)mart {
	if (mart == nil) {
		BMLog(@"WARNING: trying to request datasets for nil mart. Will ignore.");
		return;
		
	}
	BMLog(@"Requesting datasets for mart %@", mart);	
	ASIHTTPRequest *request = 
		[ASIHTTPRequest requestWithURL:[NSURL URLWithString:[[self.URL absoluteString] stringByAppendingFormat:@"?type=datasets&mart=%@",mart.name]]];
	
	[_martsByRequest setObject:mart forKey: [request.url absoluteString]];
	BMLog(@"%@ %@",_martsByRequest, request);
	[request setDelegate:self];
	[request startAsynchronous];
	[request setDidFinishSelector:@selector(didReceiveDatasets:)];
	[request setDidFailSelector:@selector(didFailToReceiveDatasets:)];
	
}

-(void) didReceiveDatasets:(ASIHTTPRequest*) req {
	BMDatasetTableParser *parser = [[[BMDatasetTableParser alloc] initWithString: [req responseString]] autorelease];
	
	NSString *key = [req.url absoluteString];
	BMart *mart = [_martsByRequest objectForKey: key];
	
	if (mart == nil) {
		@throw [NSException exceptionWithName:@"BMNilPointerException" 
									   reason:@"Unexpected nil mart" 
									 userInfo:nil];
	}

	
	mart.datasets = parser.datasets;
	
	[[NSNotificationCenter defaultCenter] postNotificationName:BMartReceivedDatasetsForMartNotification object: mart];
	//[_martsByRequest removeObjectForKey: key];
}

-(void) didFailToReceiveDatasets:(ASIHTTPRequest*) req {
	[[NSNotificationCenter defaultCenter] postNotificationName: BMartRequestDatasetsForMartFailedNotification 
														object: req.error];
}


-(void) requestConfigurationForDataset:(BMDataset*)dataset {
	BMLog(@"Requesting configuration for dataset %@", dataset.name);
	
	if (dataset == nil) {
		BMLog(@"Requesting configuration for nil database. Will ignore.");
		return;
	}
	ASIHTTPRequest *request = 
	[ASIHTTPRequest requestWithURL:[NSURL URLWithString:[[self.URL absoluteString] stringByAppendingFormat:@"?type=configuration&dataset=%@",dataset.name]]];
	
	[_datasetsByRequest setObject:dataset forKey: [request.url absoluteString]];
	//BMLog(@"%@ %@",_datasetsByRequest, request);
	[request setDelegate:self];
	[request startAsynchronous];
	[request setDidFinishSelector:@selector(didReceiveConfigurationForDataset:)];
	[request setDidFailSelector:@selector(didFailToReceiveConfigurationForDataset:)];
}

-(void) didReceiveConfigurationForDataset:(ASIHTTPRequest*)req {
	NSString *key = [req.url absoluteString];
	BMDataset *dataset = [_datasetsByRequest objectForKey: key];
	
	if (dataset == nil) {
		@throw [NSException exceptionWithName:@"BMNilPointerException" 
									   reason:@"Unexpected nil dataset" 
									 userInfo:nil];
	}
	[[[BMDatasetConfigXMLParser alloc] initWithData: [req responseData] dataset: dataset] autorelease];

	BMLog(@"Parsed configuration for dataset %@", dataset);
	
	[[NSNotificationCenter defaultCenter] postNotificationName: BMartReceivedDatasetConfigurationForDataset 
														object: dataset];
	//[_datasetsByRequest removeObjectForKey: key];
}

-(void) didFailToReceiveConfigurationForDataset:(ASIHTTPRequest*) req {
	[[NSNotificationCenter defaultCenter] postNotificationName: BMartRequestDatasetConfigurationForMartFailedNotification 
														object: req.error];
}

/*
-(void) requestAttributesForDataset:(BMDataset*)dataset {
	BMLog(@"Requesting attributes for dataset %@", dataset);	
	ASIHTTPRequest *request = 
	[ASIHTTPRequest requestWithURL:[NSURL URLWithString:[[self.URL absoluteString] stringByAppendingFormat:@"?type=attributes&dataset=%@",dataset.name]]];
	
	[_datasetsByRequest setObject:dataset forKey: [request.url absoluteString]];
	BMLog(@"%@ %@",_datasetsByRequest, request);
	[request setDelegate:self];
	[request startAsynchronous];
	[request setDidFinishSelector:@selector(didReceiveAttributesForDataset:)];
	[request setDidFailSelector:@selector(didFailToReceiveAttributesForDataset:)];
}

-(void) didReceiveAttributesForDataset:(ASIHTTPRequest*) req {
	BMLog(@"Received attributes for dataset");
	BMAttributeTableParser *parser = [[[BMAttributeTableParser alloc] initWithString: [req responseString]] autorelease];
	
	NSString *key = [req.url absoluteString];	
	BMDataset *dataset = [_datasetsByRequest objectForKey: key];
	
	if (dataset == nil) {
		@throw [NSException exceptionWithName:@"BMNilPointerException" 
									   reason:@"Unexpected nil dataset" 
									 userInfo:nil];
	}
	[_datasetsByRequest removeObjectForKey: key];
	
	dataset.attributes = [parser.attributes mutableCopy];
	
	[[NSNotificationCenter defaultCenter] postNotificationName: BMartReceivedAttributesForDatasetNotification 
														object: dataset];
}

-(void) didFailToreceiveAttributesForDataset:(ASIHTTPRequest*) req {
	BMLog(@"Failed to receive attributes for dataset");
	[[NSNotificationCenter defaultCenter] postNotificationName: BMartRequestAttributesForDatasetFailedNotification 
														object: req.error];
}

-(void) requestFiltersForDataset:(BMDataset*)dataset {
	BMLog(@"Requesting filters for dataset %@", dataset);	
	ASIHTTPRequest *request = 
	[ASIHTTPRequest requestWithURL:[NSURL URLWithString:[[self.URL absoluteString] stringByAppendingFormat:@"?type=filters&dataset=%@",dataset.name]]];
	
	[_datasetsByRequest setObject:dataset forKey: [request.url absoluteString]];
	BMLog(@"%@ %@",_datasetsByRequest, request);
	[request setDelegate:self];
	[request startAsynchronous];
	[request setDidFinishSelector:@selector(didReceiveFiltersForDataset:)];
	[request setDidFailSelector:@selector(didFailToReceiveFiltersForDataset:)];
}

-(void) didReceiveFiltersForDataset:(ASIHTTPRequest*) req {
	BMLog(@"Received filters for dataset");
	BMFilterTableParser *parser = [[[BMFilterTableParser alloc] initWithString: [req responseString]] autorelease];
	
	NSString *key = [req.url absoluteString];	
	BMDataset *dataset = [_datasetsByRequest objectForKey: key];
	
	if (dataset == nil) {
		@throw [NSException exceptionWithName:@"BMNilPointerException" 
									   reason:@"Unexpected nil dataset" 
									 userInfo:nil];
	}
	[_datasetsByRequest removeObjectForKey: key];
	
	dataset.filters = [parser.filters mutableCopy];
	
	[[NSNotificationCenter defaultCenter] postNotificationName: BMartReceivedFiltersForDatasetNotification 
														object: dataset];
}

-(void) didFailToreceiveFiltersForDataset:(ASIHTTPRequest*) req {
	BMLog(@"Failed to receive filters for dataset");
	[[NSNotificationCenter defaultCenter] postNotificationName: BMartRequestFiltersForDatasetFailedNotification 
														object: req.error];
}
*/
@end
