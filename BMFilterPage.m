//
//  BMFilterPage.m
//  Biomartify
//
//  Created by Matias Piipari on 09/05/2010.
//  Copyright 2010 Wellcome Trust Sanger Institute. All rights reserved.
//

#import "BMFilterPage.h"


@implementation BMFilterPage
@synthesize filterGroups = _filterGroups;
@synthesize hideDisplay = _hideDisplay;
@synthesize internalName = _internalName;
@synthesize displayName = _displayName;

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
    [_filterGroups release], _filterGroups = nil;
    [_internalName release], _internalName = nil;
	[_displayName release], _displayName = nil;
    [super dealloc];
}

-(NSString*) description {
	return [NSString stringWithFormat:@"[BMFilterPage displayName:%@ internalName:%@ groups:%@]",
			self.displayName, self.internalName, self.filterGroups];
}

-(NSComparisonResult) compareAlphabetically:(id)obj {
	return [self.displayName caseInsensitiveCompare: [obj displayName]];
}

@end