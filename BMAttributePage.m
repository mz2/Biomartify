//
//  BMAttributePage.m
//  Biomartify
//
//  Created by Matias Piipari on 09/05/2010.
//  Copyright 2010 Wellcome Trust Sanger Institute. All rights reserved.
//

#import "BMAttributePage.h"


@implementation BMAttributePage
@synthesize desc = _desc;
@synthesize displayName = _displayName;
@synthesize internalName = _internalName;
@synthesize outFormats = _outFormats;
@synthesize attributeGroups = _attributeGroups;

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
    [_outFormats release], _outFormats = nil;
    [_attributeGroups release], _attributeGroups = nil;
	
    [super dealloc];
}

-(NSComparisonResult) compareAlphabetically:(id)obj {
	return [self.displayName caseInsensitiveCompare: [obj displayName]];
}


#pragma mark Filter tree node

-(NSArray*) attribTreeChildren {
	return self.attributeGroups;
}

-(NSUInteger) attribTreeChildCount {
	return self.attributeGroups.count;
}

-(BOOL) attribTreeIsLeaf {
	return self.attributeGroups.count == 0;
}

@end