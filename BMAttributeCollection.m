//
//  BMAttributeCollection.m
//  Biomartify
//
//  Created by Matias Piipari on 09/05/2010.
//  Copyright 2010 Wellcome Trust Sanger Institute. All rights reserved.
//

#import "BMAttributeCollection.h"


@implementation BMAttributeCollection
@synthesize desc = _desc;
@synthesize displayName = _displayName;
@synthesize internalName = _internalName;
@synthesize attributes = _attributes;

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
    [_attributes release], _attributes = nil;
	
    [super dealloc];
}

-(NSComparisonResult) compareAlphabetically:(id)obj {
	return [self.displayName caseInsensitiveCompare: [obj displayName]];
}

#pragma mark Filter tree node

-(NSArray*) attribTreeChildren {
	return self.attributes;
}

-(NSUInteger) attribTreeChildCount {
	return self.attributes.count;
}

-(BOOL) attribTreeIsLeaf {
	return self.attributes.count == 0;
}
@end