//
//  BMDataset.m
//  Biomartify
//
//  Created by Matias Piipari on 07/05/2010.
//  Copyright 2010 Wellcome Trust Sanger Institute. All rights reserved.
//

#import "BMDataset.h"


@implementation BMDataset
@synthesize identifier = _identifier;
@synthesize desc = _desc;
@synthesize type = _type;

@synthesize name = _name;
@synthesize internalName = _internalName;
@synthesize displayName = _displayName;
@synthesize martUsers = _martUsers;
@synthesize entryLabel = _entryLabel;
@synthesize visible = _visible;
@synthesize interface = _interface;
@synthesize interfaces = _interfaces;
@synthesize version = _version;
@synthesize softwareVersion = _softwareVersion;
@synthesize modifiedDate = _modifiedDate;
@synthesize datasetTemplate = _datasetTemplate;
@synthesize filters = _filters;
@synthesize attributes = _attributes;

@synthesize filterPages = _filterPages;
@synthesize attributePages = _attributePages;

@synthesize defaultDataset = _defaultDataset;

@synthesize isConfigured = _isConfigured;

@synthesize availableFilters = _availableFilters;
@synthesize availableAttributes = _availableAttributes;

//=========================================================== 
// - (id)init
//
//=========================================================== 
- (id)init
{
    if (self = [super init]) {
        [self setName: nil];
        [self setInterface: @"default"];
    }
    return self;
}

+ (id) dataset {
	return [[[[self class] alloc] init] autorelease];
}

//=========================================================== 
// dealloc
//=========================================================== 
- (void)dealloc
{
    [_identifier release], _identifier = nil;
    [_desc release], _desc = nil;
	[_type release], _type = nil;
    [_name release], _name = nil;
    [_internalName release], _internalName = nil;
    [_displayName release], _displayName = nil;
    [_martUsers release], _martUsers = nil;
	[_entryLabel release], _entryLabel = nil;
    [_interface release], _interface = nil;
	[_interfaces release], _interfaces = nil;
    [_version release], _version = nil;
    [_softwareVersion release], _softwareVersion = nil;
    [_modifiedDate release], _modifiedDate = nil;
    [_datasetTemplate release], _datasetTemplate = nil;
    [_filters release], _filters = nil;
    [_attributes release], _attributes = nil;	
    [_filterPages release], _filterPages = nil;
    [_attributePages release], _attributePages = nil;
	
	
    [super dealloc];
}

-(NSString*) description {
	if (self.displayName != nil) {
		return [self.displayName copy];		
	} else if (self.name != nil) {
		return [self.name copy];
	} else {
		return [super description];
	}

}

-(NSComparisonResult) compareAlphabetically:(BMDataset*)dataset {
	return [self.displayName caseInsensitiveCompare: dataset.displayName];
}

-(BOOL) isLeaf {return YES;}

-(NSImage*) icon {
	return [NSImage imageNamed:@"dataset-list-view.png"];
}

-(NSArray*) availableFilters {
	NSMutableArray *fs = [NSMutableArray array];
	for (id key in [self.filters allKeys]) {
		[fs addObject:[self.filters objectForKey: key]];
	}
	
	[fs sortUsingSelector:@selector(compareAlphabetically:)];
	return [fs copy];
}

-(NSArray*) availableAttributes {
	NSMutableArray *as = [NSMutableArray array];
	for (id key in [self.attributes allKeys]) {
		[as addObject:[self.attributes objectForKey: key]];
	}
	
	[as sortUsingSelector:@selector(compareAlphabetically:)];
	return [as copy];	
}


@end
