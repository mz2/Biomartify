//
//  BMRegistry.m
//  Biomartify
//
//  Created by Matias Piipari on 07/05/2010.
//  Copyright 2010 Wellcome Trust Sanger Institute. All rights reserved.
//

#import "BMRegistry.h"
#import "BMart.h"

@implementation BMRegistry
@synthesize url = _url;
@synthesize marts = _marts;
@synthesize martsByName = _martsByName;
//=========================================================== 
// - (id)init
//
//=========================================================== 
- (id)init
{
    if (self = [super init]) {
        [self setMarts: [NSMutableArray array]];
    }
    return self;
}

//=========================================================== 
// + (void)initialize
//
//=========================================================== 
+ (void)initialize 
{
    [[self class] setKeys:
	 [NSArray arrayWithObjects: @"marts", nil]
triggerChangeNotificationsForDependentKey: @"visibleMarts"];
}

-(NSArray*) visibleMarts {
	return [self.marts filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"visible == true"]];
}

-(void) setMarts:(NSMutableArray *) marts {
	[self willChangeValueForKey:@"marts"];
	
	[marts retain];
	[_marts release];
	_marts = marts;
	
	[_martsByName release];
	_martsByName = [[NSMutableDictionary alloc] init];
	for (BMart *mart in self.marts) {
		[_martsByName setObject:mart forKey:mart.name];
	}
	
	[self didChangeValueForKey:@"marts"];
}

-(BMart*) martWithName:(NSString *)name {
	return [_martsByName objectForKey: name];
}

//=========================================================== 
// dealloc
//=========================================================== 
- (void)dealloc
{
    [_marts release], _marts = nil;
	[_martsByName release] ,_martsByName = nil;
	[_url release], _url = nil;
    [super dealloc];
}

-(NSString*) description {
	return [NSString stringWithFormat:@"[BMRegistry marts:%@]",self.marts];
}

@end
