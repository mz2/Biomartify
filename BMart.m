//
//  BMart.m
//  Biomartify
//
//  Created by Matias Piipari on 07/05/2010.
//  Copyright 2010 Wellcome Trust Sanger Institute. All rights reserved.
//

#import "BMart.h"


@implementation BMart
@synthesize database = _database;
@synthesize isDefault = _isDefault;
@synthesize displayName = _displayName;
@synthesize host = _host;
@synthesize includeDatasets = _includeDatasets;
@synthesize martUser = _martUser;
@synthesize name = _name;
@synthesize path = _path;
@synthesize port = _port;
@synthesize serverVirtualSchema = _serverVirtualSchema;
@synthesize visible = _visible;

//=========================================================== 
// - (id)initWith:
//
//=========================================================== 
- (id)initWithDatabase:(NSString*)aDatabase 
			 isDefault:(BOOL)flag
		   displayName:(NSString*)aDisplayName
				  host:(NSString*)anHost 
	   includeDatasets:(NSArray*)anIncludeDatasets 
			  martUser:(NSString*)aMartUser
				  name:(NSString*)aName 
				  path:(NSString*)aPath
				  port:(NSUInteger)aPort 
   serverVirtualSchema:(NSString*)aServerVirtualSchema
			   visible:(BOOL)flag 
{
    if (self = [super init]) {
        [self setDatabase:aDatabase];
        [self setIsDefault:flag];
        [self setDisplayName:aDisplayName];
        [self setHost:anHost];
        [self setIncludeDatasets:anIncludeDatasets];
        [self setMartUser:aMartUser];
        [self setName:aName];
        [self setPath:aPath];
        [self setPort:aPort];
        [self setServerVirtualSchema:aServerVirtualSchema];
        [self setVisible:flag];
    }
    return self;
}


//=========================================================== 
// + (id)objectWith:
//
//=========================================================== 
+ (id)martWithDatabase:(NSString*)aDatabase 
			 isDefault:(BOOL)flag 
		   displayName:(NSString*)aDisplayName 
				  host:(NSString*)anHost 
	   includeDatasets:(NSArray*)anIncludeDatasets 
			  martUser:(NSString*)aMartUser 
				  name:(NSString*)aName
				  path:(NSString*)aPath
				  port:(NSUInteger)aPort 
   serverVirtualSchema:(NSString*)aServerVirtualSchema 
			   visible:(BOOL)flag  
{
    id result = [[[self class] alloc] initWithDatabase:aDatabase 
											 isDefault:flag 
										   displayName:aDisplayName 
												  host:anHost
									   includeDatasets:anIncludeDatasets
											  martUser:aMartUser
												  name:aName 
												  path:aPath
												  port:aPort
								   serverVirtualSchema:aServerVirtualSchema 
											   visible:flag];
	
    return [result autorelease];
}


//=========================================================== 
// dealloc
//=========================================================== 
- (void)dealloc
{
    [_database release], _database = nil;
    [_displayName release], _displayName = nil;
    [_host release], _host = nil;
    [_includeDatasets release], _includeDatasets = nil;
    [_martUser release], _martUser = nil;
    [_name release], _name = nil;
    [_path release], _path = nil;
    [_serverVirtualSchema release], _serverVirtualSchema = nil;
	
    [super dealloc];
}

@end
