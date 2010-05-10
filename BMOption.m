//
//  BMOption.m
//  Biomartify
//
//  Created by Matias Piipari on 09/05/2010.
//  Copyright 2010 Wellcome Trust Sanger Institute. All rights reserved.
//

#import "BMOption.h"


@implementation BMOption
@synthesize displayName = _displayName;
@synthesize displayType = _displayType;
@synthesize field = _field;
@synthesize hidden = _hidden;
@synthesize internalName = _internalName;
@synthesize isSelectable = _isSelectable;
@synthesize key = _key;
@synthesize legalQualifiers = _legalQualifiers;
@synthesize qualifier = _qualifier;
@synthesize style = _style;
@synthesize tableConstraint = _tableConstraint;
@synthesize type = _type;
@synthesize options = _options;

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
    [_displayType release], _displayType = nil;
    [_field release], _field = nil;
    [_internalName release], _internalName = nil;
    [_key release], _key = nil;
    [_legalQualifiers release], _legalQualifiers = nil;
    [_qualifier release], _qualifier = nil;
    [_style release], _style = nil;
    [_tableConstraint release], _tableConstraint = nil;
    [_type release], _type = nil;
    [_options release], _options = nil;
	
    [super dealloc];
}

-(NSString*) desc {
	return self.displayType;
}

-(NSString*) description {
	return [NSString stringWithFormat: @"[BMOption type:%@ style:%@ displayName:%@ displayType internalName:%@ legalQualifiers:%@ qualifier: %@ options: %@",
			self.type, self.style, self.displayName,self.displayName,self.internalName, self.legalQualifiers, self.qualifier, self.options];
}

-(NSComparisonResult) compareAlphabetically:(id)obj {
	return [self.displayName caseInsensitiveCompare: [obj displayName]];
}


#pragma mark Filter tree node

-(NSArray*) filterTreeChildren {
	return nil;
}

-(NSUInteger) filterTreeChildCount {
	return 0;
}

-(BOOL) filterTreeIsLeaf {
	return YES;
}

@end
