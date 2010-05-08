//
//  BMartService.m
//  Biomartify
//
//  Created by Matias Piipari on 07/05/2010.
//  Copyright 2010 Wellcome Trust Sanger Institute. All rights reserved.
//

#import "BMartService.h"
#import "BMRegistryXMLParser.h"
#import "ASIHTTPRequest.h"

@implementation BMartService
@synthesize baseURL = _baseURL;
//@synthesize delegate = _delegate;
@synthesize cachedRegistry = _cachedRegistry;

//=========================================================== 
// - (id)init
//
//=========================================================== 
- (id)init
{
    if (self = [super init]) {
        [self setBaseURL: nil];
        [self setCachedRegistry: nil];
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
    [defaultValues setObject: BMServiceBaseURLDefault 
					  forKey: BMServiceBaseURLKey];
	
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
    [_baseURL release], _baseURL = nil;
    [_cachedRegistry release], _cachedRegistry = nil;
    [_cachedDatasets release], _cachedDatasets = nil;
	
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
	BMRegistryXMLParser *parser = [[BMRegistryXMLParser alloc] initWithData: [req responseData]];
	
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
	
}

-(void) requestAttributesForDataset:(BMDataset*)dataset {
	
}

-(void) requestFiltersForDataset:(BMDataset*)dataset {
	
}



@end
