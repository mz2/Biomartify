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
@synthesize datasets = _datasets;

+ (void)initialize 
{
    [[self class] setKeys:
	 [NSArray arrayWithObjects: @"datasets", nil]
triggerChangeNotificationsForDependentKey: @"visibleDatasets"];
	[[self class] setKeys:
	 [NSArray arrayWithObjects: @"datasets", nil]
triggerChangeNotificationsForDependentKey: @"isLeaf"];
}


//=========================================================== 
// - (id)initWith:
//
//=========================================================== 
- (id)initWithDatabase:(NSString*)aDatabase 
			 isDefault:(BOOL)isDefault
		   displayName:(NSString*)aDisplayName
				  host:(NSString*)anHost 
	   includeDatasets:(NSArray*)anIncludeDatasets 
			  martUser:(NSString*)aMartUser
				  name:(NSString*)aName 
				  path:(NSString*)aPath
				  port:(NSUInteger)aPort 
   serverVirtualSchema:(NSString*)aServerVirtualSchema
			   visible:(BOOL)visible 
{
    if (self = [super init]) {
        [self setDatabase:aDatabase];
        [self setIsDefault:isDefault];
        [self setDisplayName:aDisplayName];
        [self setHost:anHost];
        [self setIncludeDatasets:anIncludeDatasets];
        [self setMartUser:aMartUser];
        [self setName:aName];
        [self setPath:aPath];
        [self setPort:aPort];
        [self setServerVirtualSchema:aServerVirtualSchema];
        [self setVisible:visible];
    }
    return self;
}


//=========================================================== 
// + (id)objectWith:
//
//=========================================================== 
+ (id)martWithDatabase:(NSString*)aDatabase 
			 isDefault:(BOOL)isDefault 
		   displayName:(NSString*)aDisplayName 
				  host:(NSString*)anHost 
	   includeDatasets:(NSArray*)anIncludeDatasets 
			  martUser:(NSString*)aMartUser 
				  name:(NSString*)aName
				  path:(NSString*)aPath
				  port:(NSUInteger)aPort 
   serverVirtualSchema:(NSString*)aServerVirtualSchema 
			   visible:(BOOL)visible  
{
    id result = [[[self class] alloc] initWithDatabase:aDatabase 
											 isDefault:isDefault 
										   displayName:aDisplayName 
												  host:anHost
									   includeDatasets:anIncludeDatasets
											  martUser:aMartUser
												  name:aName 
												  path:aPath
												  port:aPort
								   serverVirtualSchema:aServerVirtualSchema 
											   visible:visible];
	
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
	
	[_datasets release], _datasets = nil;
	
    [super dealloc];
}

-(NSString*) description {
	return [self.displayName copy];
}

-(BOOL) isEqual:(BMart*) obj {
	if (![obj isKindOfClass:[BMart class]]) {
		return NO;
	}
	
	if ([obj name] == [self name]) {return YES;}
	return NO;
}

-(NSString*) displayName {
	return [_displayName lowercaseString];
}


-(NSArray*) visibleDatasets {
	return [self.datasets filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"visible == true"]];
}

-(NSComparisonResult) compareAlphabetically:(BMart*)mart {
	return [self.displayName caseInsensitiveCompare: mart.displayName];
}

#pragma mark Tree node

-(BOOL) isLeaf {
	return (self.datasets.count == 0);
}

- (NSArray*)children {
	return self.datasets;
}

-(NSUInteger) countOfChildren {
	return self.datasets.count;
}

- (id)objectInChildrenAtIndex:(NSUInteger)index {
	if (self.isLeaf) return nil;
	return [self.datasets objectAtIndex:index];
}

-(NSImage*) icon {
	return [NSImage imageNamed:@"mart-list-view.png"];
}

@end
