//
//  BMFilterCollection.m
//  Biomartify
//
//  Created by Matias Piipari on 09/05/2010.
//  Copyright 2010 Wellcome Trust Sanger Institute. All rights reserved.
//

#import "BMFilterCollection.h"


@implementation BMFilterCollection
@synthesize displayName = _displayName;
@synthesize desc = _desc;
@synthesize hidden = _hidden;
@synthesize internalName = _internalName;
@synthesize filters = _filters;

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
	[_desc release], _desc = nil;
    [_displayName release], _displayName = nil;
    [_internalName release], _internalName = nil;
	[_filters release], _filters = nil;
    [super dealloc];
}

-(NSString*) description {
	return [NSString stringWithFormat:@"[BMFilterCollection displayName:%@ internalName:%@ desc:%@ filters:%@]", 
			self.displayName, self.internalName, self.desc, self.filters];
}

-(NSComparisonResult) compareAlphabetically:(id)obj {
	return [self.displayName caseInsensitiveCompare: [obj displayName]];
}


#pragma mark Filter tree node

-(NSArray*) filterTreeChildren {
	return self.filters;
}

-(NSUInteger) filterTreeChildCount {
	return self.filters.count;
}

-(BOOL) filterTreeIsLeaf {
	return self.filters.count == 0;
}
@end
