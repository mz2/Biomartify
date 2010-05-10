//
//  BMAttribute.m
//  Biomartify
//
//  Created by Matias Piipari on 07/05/2010.
//  Copyright 2010 Wellcome Trust Sanger Institute. All rights reserved.
//

#import "BMAttribute.h"


@implementation BMAttribute
@synthesize isDefault = _isDefault;
@synthesize desc = _desc;
@synthesize displayName = _displayName;
@synthesize field = _field;
@synthesize internalName = _internalName;
@synthesize key = _key;
@synthesize linkoutURL = _linkoutURL;
@synthesize maxLength = _maxLength;
@synthesize tableConstraint = _tableConstraint;

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

+(id) attribute {
	return [[[BMAttribute alloc] init] autorelease];
}

//=========================================================== 
// dealloc
//=========================================================== 
- (void)dealloc
{
    [_desc release], _desc = nil;
    [_displayName release], _displayName = nil;
    [_field release], _field = nil;
    [_internalName release], _internalName = nil;
    [_key release], _key = nil;
    [_linkoutURL release], _linkoutURL = nil;
    [_tableConstraint release], _tableConstraint = nil;
	
    [super dealloc];
}

-(NSComparisonResult) compareAlphabetically:(id)obj {
	return [[self displayName] caseInsensitiveCompare: [obj displayName]];
}

#pragma mark Filter tree node

-(NSArray*) attribTreeChildren {
	return nil;
}

-(NSUInteger) attribTreeChildCount {
	return 0;
}

-(BOOL) attribTreeIsLeaf {
	return YES;
}

@end
