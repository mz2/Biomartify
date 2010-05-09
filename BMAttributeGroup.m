//
//  BMAttributeGroup.m
//  Biomartify
//
//  Created by Matias Piipari on 09/05/2010.
//  Copyright 2010 Wellcome Trust Sanger Institute. All rights reserved.
//

#import "BMAttributeGroup.h"


@implementation BMAttributeGroup
@synthesize desc = _desc;
@synthesize displayName = _displayName;
@synthesize internalName = _internalName;
@synthesize attributeCollections = _attributeCollections;

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
    [_attributeCollections release], _attributeCollections = nil;
	
    [super dealloc];
}

-(NSComparisonResult) compareAlphabetically:(id)obj {
	return [self.displayName caseInsensitiveCompare: [obj displayName]];
}
@end
