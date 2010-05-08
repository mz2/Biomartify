//
//  BMartService.m
//  Biomartify
//
//  Created by Matias Piipari on 07/05/2010.
//  Copyright 2010 Wellcome Trust Sanger Institute. All rights reserved.
//

#import "BMartService.h"
#import "BMRegistryXMLParser.h"

@implementation BMartService
@synthesize baseURL = _baseURL;
@synthesize delegate = _delegate;
@synthesize cachedRegistry = _cachedRegistry;
@synthesize cachedDatasets = _cachedDatasets;

//=========================================================== 
// - (id)init
//
//=========================================================== 
- (id)init
{
    if (self = [super init]) {
        [self setBaseURL: nil];
        [self setDelegate: nil];
        [self setCachedRegistry: nil];
        [self setCachedDatasets: nil];
    }
    return self;
}

//=========================================================== 
// dealloc
//=========================================================== 
- (void)dealloc
{
    [_baseURL release], _baseURL = nil;
    _delegate = nil;
    [_cachedRegistry release], _cachedRegistry = nil;
    [_cachedDatasets release], _cachedDatasets = nil;
	
    [super dealloc];
}



#pragma mark Requests
-(void) requestRegistryForMartServiceAtURL:(NSURL*)url {
	NSString *baseURLStr = [[NSUserDefaults standardUserDefaults] objectForKey:BMServiceBaseURLKey];
	NSURL *url = [NSURL URLWithString:[baseURLStr stringByAppendingFormat:@"?type=registry"]];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
	[request setDelegate:self];
	[request startAsynchronous];
	[request setDidFinishSelector:@selector(didReceiveRegistry:)];
	[request setDidFailSelector:@selector(didFailToReceiveRegistry:)];
}

-(void) didReceiveRegistry:(ASIHTTPRequest*) req {
	BMRegistryXMLParser *parser = [[BMRegistryXMLParser alloc] initWithData: [req responseData]];
	
	[self.delegate registryReceived:registry];
}

-(void) didFailToReceiveRegistry:(ASIHTTPRequest*) req {
	[self.delegate registryRequestFailed: req.error];
}

-(void) requestDatasetsForMart:(BMart*)mart {
	
}

-(void) requestAttributesForDataset:(BMDataset*)dataset {
	
}

-(void) requestFiltersForDataset:(BMDataset*)dataset {
	
}

#pragma mark Singleton

static BMartService *sharedInstance = nil; 

+ (void)initialize
{
    if (sharedInstance == nil)
        sharedInstance = [[self alloc] init];
}

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



@end
