//
//  BMFilter.m
//  Biomartify
//
//  Created by Matias Piipari on 07/05/2010.
//  Copyright 2010 Wellcome Trust Sanger Institute. All rights reserved.
//

#import "BMFilter.h"


@implementation BMFilter
@synthesize internalName = _internalName;
@synthesize displayName = _displayName;
@synthesize displayType = _displayType;
@synthesize hidden = _hidden;
@synthesize type = _type;
@synthesize options = _options;

+(id) filter {
	return [[[[BMFilter class] alloc] init] autorelease];
}

//=========================================================== 
// - (id)init
//
//=========================================================== 
- (id)init
{
    if (self = [super init]) {
    }
    return self;
}


//=========================================================== 
// dealloc
//=========================================================== 
- (void)dealloc
{
    [_internalName release], _internalName = nil;
    [_displayName release], _displayName = nil;
    [_displayType release], _displayType = nil;
    [_type release], _type = nil;
    [_options release], _options = nil;
	
    [super dealloc];
}

-(NSString*) description {
	return [NSString stringWithFormat:@"[BMFilter displayName:%@ internalName:%@ displayType:%@ type:%@ options:%@]", 
			self.displayName,self.internalName, self.displayType, self.type, self.options];
}


-(NSComparisonResult) compareAlphabetically:(BMFilter*)filter {
	return [self.displayName caseInsensitiveCompare: filter.displayName];
}


@end
