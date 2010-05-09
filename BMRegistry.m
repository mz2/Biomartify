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
	[[self class] setKeys:
	 [NSArray arrayWithObjects: @"marts", nil]
triggerChangeNotificationsForDependentKey: @"isLeaf"];
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

#pragma mark Tree node

-(NSString*) displayName {
	return [NSString stringWithFormat:@"Biomart registry"];
}

-(BOOL) isLeaf {
	return (self.marts.count == 0);
}

- (NSArray*)children {
	return self.marts;
}

-(NSUInteger) countOfChildren {
	return self.marts.count;
}

- (id)objectInChildrenAtIndex:(NSUInteger)index {
	if (self.isLeaf) return nil;
	return [self.marts objectAtIndex:index];
}

-(NSImage*) icon {
	return [NSImage imageNamed:@"registry-list-view.gif"];
}

@end
