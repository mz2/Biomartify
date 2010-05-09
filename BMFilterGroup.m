//
//  BMFilterGroup.m
//  Biomartify
//
//  Created by Matias Piipari on 09/05/2010.
//  Copyright 2010 Wellcome Trust Sanger Institute. All rights reserved.
//

#import "BMFilterGroup.h"


@implementation BMFilterGroup
@synthesize displayName = _displayName;
@synthesize desc = _desc;
@synthesize hidden = _hidden;
@synthesize internalName = _internalName;
@synthesize filterCollections = _filterCollections;

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
    [_displayName release], _displayName = nil;
    [_desc release], _desc = nil;
    [_internalName release], _internalName = nil;
	[_filterCollections release], _filterCollections = nil;
	
    [super dealloc];
}

-(NSString*) description {
	return [NSString stringWithFormat:@"[BMFilterGroup displayName:%@ desc:%@ internalName:%@]", 
			self.displayName, self.desc, self.internalName];
}


-(NSComparisonResult) compareAlphabetically:(id)obj {
	return [self.displayName caseInsensitiveCompare: [obj displayName]];
}

@end
