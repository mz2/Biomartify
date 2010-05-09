//
//  BMDataset.h
//  Biomartify
//
//  Created by Matias Piipari on 07/05/2010.
//  Copyright 2010 Wellcome Trust Sanger Institute. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "BMFilter.h"
#import "BMAttribute.h"

@interface BMDataset : NSObject {
	NSString *_identifier;
	NSString *_desc;
	NSString *_type;
	
	NSString *_name;
	NSString *_internalName;
	NSString *_displayName;
	
	NSArray *_martUsers;
	
	NSString *_entryLabel;
	
	BOOL _visible;
	
	NSString *_interface;
	NSArray *_interfaces;
	NSString *_version;
	NSString *_softwareVersion;
	
	NSDate *_modifiedDate;
	
	NSString *_datasetTemplate;
	
	NSMutableDictionary *_filters;
	NSMutableDictionary *_attributes;
	
	NSArray *_filterPages;
	NSArray *_attributePages;
	
	BOOL _defaultDataset;
	
	BOOL _isConfigured;
}

@property(nonatomic,copy)NSString *identifier;
@property(nonatomic,copy)NSString *desc;
@property(nonatomic,copy)NSString *type;

@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *internalName;
@property(nonatomic,copy)NSString *displayName;

@property(nonatomic,copy)NSArray *martUsers;

@property(nonatomic,copy)NSString *entryLabel;

@property(nonatomic,assign)BOOL visible;

@property(nonatomic,copy)NSString *interface;
@property(nonatomic,retain)NSArray *interfaces;

@property(nonatomic,copy)NSString *version;
@property(nonatomic,copy)NSString *softwareVersion;

@property(nonatomic,retain) NSDate *modifiedDate;
@property(nonatomic,retain) NSString *datasetTemplate; //template is a reserved word

@property(nonatomic,retain)NSMutableDictionary *filters;
@property(nonatomic,retain)NSMutableDictionary *attributes;

@property(nonatomic,retain)NSArray *filterPages;
@property(nonatomic,retain)NSArray *attributePages;

@property(nonatomic,assign)BOOL defaultDataset;

@property(nonatomic,assign)BOOL isConfigured;

@property(nonatomic,readonly)NSArray *availableFilters;
@property(nonatomic,readonly)NSArray *availableAttributes;

+ (id)dataset;
-(NSImage*) icon;
-(NSComparisonResult) compareAlphabetically:(BMDataset*)dataset;
@end