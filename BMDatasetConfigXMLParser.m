//
//  BMDatasetConfigXMLParser.m
//  Biomartify
//
//  Created by Matias Piipari on 09/05/2010.
//  Copyright 2010 Wellcome Trust Sanger Institute. All rights reserved.
//

#import "BMDatasetConfigXMLParser.h"
#import "BMDataset.h"
#import "BMFilter.h"
#import "BMFilterCollection.h"
#import "BMFilterGroup.h"
#import "BMFilterPage.h"
#import "BMAttribute.h"
#import "BMAttributeCollection.h"
#import "BMAttributeGroup.h"
#import "BMAttributePage.h"
#import "BMOption.h"

@interface BMDatasetConfigXMLParser (private)
-(void) configureDatasetWithXMLDocument:(NSXMLDocument*)doc error:(NSError**)error;
-(void) parseOptions:(NSXMLElement*)optionElem forFilter:(BMFilter*) filter;
@end

@implementation BMDatasetConfigXMLParser
@synthesize dataset = _dataset;
@synthesize error = _error;

- (id)initWithData:(NSData*) data dataset:(BMDataset*)dataset
{
    if (self = [super init]) {
		_dataset = [dataset retain];
		
		NSError *error = nil;
		_document = [[NSXMLDocument alloc] initWithData: data options:(NSXMLNodePreserveWhitespace|NSXMLNodePreserveCDATA) error:&error];
		if (error != nil) {
			BMLog(@"Parsing failed");
			_error = [_error retain];
		} else {
			BMLog(@"Parsing succeeded (%@)", _dataset);
		}
		
		[self configureDatasetWithXMLDocument:_document error:&error];
		
		if (error != nil) {
			BMLog(@"Configuring dataset failed");
		} else {
			BMLog(@"Configuring dataset succeeded");
			self.dataset.isConfigured = YES;
		}
    }
    return self;
}

-(void) configureDatasetWithXMLDocument:(NSXMLDocument*)doc error:(NSError**)err {
	NSError *error;
	
	NSXMLElement *elem = [doc rootElement];
	//self.dataset.name = [elem attributeForName:@"dataset"];
	self.dataset.identifier = [[elem attributeForName:@"datasetID"] stringValue];
	self.dataset.desc = [[elem attributeForName:@"description"] stringValue];
	self.dataset.displayName = [[elem attributeForName:@"displayName"] stringValue];
	self.dataset.entryLabel = [[elem attributeForName:@"entryLabel"] stringValue];
	self.dataset.interfaces = [[[elem attributeForName:@"interfaces"] stringValue] componentsSeparatedByString:@" "];
	self.dataset.internalName = [[elem attributeForName:@"internalName"] stringValue];
	self.dataset.martUsers = [[[elem attributeForName:@"martUsers"] stringValue] componentsSeparatedByString:@"martUsers"];
	
	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[dateFormatter setDateFormat:@"yyyy-MM-dd MM:SS:FF"];
	
	self.dataset.modifiedDate = [dateFormatter dateFromString:[[elem attributeForName:@"modified"] stringValue]]; //2010-03-08 14:53:40
	self.dataset.softwareVersion = [[elem attributeForName:@"softwareVersion"] stringValue];
	self.dataset.datasetTemplate = [[elem attributeForName:@"template"] stringValue];
	self.dataset.type = [[elem attributeForName:@"type" ] stringValue];
	self.dataset.version = [[elem attributeForName:@"version"] stringValue];
	self.dataset.visible = [[[elem attributeForName:@"visible"] stringValue] boolValue];
	
	NSArray *filterDescs = [doc nodesForXPath:@"//FilterDescription" error:&error];
	
	NSMutableDictionary *filters = [NSMutableDictionary dictionary];
	
	if (error) {*err = error;return;}
	
	for (NSXMLElement *desc in filterDescs) {
		BMFilter *filter = [BMFilter filter];
		filter.displayName = [[desc attributeForName:@"displayName"] stringValue];
		filter.displayType = [[desc attributeForName:@"displayType"] stringValue];
		filter.hidden = [[[desc attributeForName:@"hidden"] stringValue] boolValue];
		filter.internalName = [[desc attributeForName:@"internalName"] stringValue];
		
		filter.type = [[desc attributeForName:@"type"] stringValue];
		filter.options = [NSMutableArray array];
		
		for (NSXMLElement *elem in [desc elementsForName:@"Option"]) {
			[self parseOptions: elem forFilter: filter];
		}
		
		[filters setObject:filter forKey:filter.internalName];
	}
	
	NSMutableArray *filterPages = [NSMutableArray array];
	NSArray *filterPageDescs = [doc nodesForXPath:@"//FilterPage" error:&error];
	if (error) {*err = error;return;}
	
	for (NSXMLElement *desc in filterPageDescs) {
		BMFilterPage *page = [[[BMFilterPage alloc] init] autorelease];
		
		page.hideDisplay = [[[desc attributeForName:@"hideDisplay"] stringValue] boolValue];
		page.internalName = [[desc attributeForName:@"internalName"] stringValue];
		page.displayName = [[desc attributeForName:@"displayName"] stringValue];
		
		NSMutableArray *groups = [NSMutableArray array];
		for (NSXMLElement *groupElem in [desc elementsForName:@"FilterGroup"]) {
			BMFilterGroup *filterGroup = [[[BMFilterGroup alloc] init] autorelease];
			filterGroup.desc = [[groupElem attributeForName:@"description"] stringValue];
			filterGroup.displayName = [[groupElem attributeForName:@"displayName"] stringValue];
			filterGroup.hidden = [[[groupElem attributeForName:@"hidden"] stringValue] boolValue];
			filterGroup.internalName = [[groupElem attributeForName:@"internalName"] stringValue];
			
			NSMutableArray *collections = [NSMutableArray array];
			
			for (NSXMLElement *collElem in [groupElem elementsForName:@"FilterCollection"]) {
				BMFilterCollection *collection = [[[BMFilterCollection alloc] init] autorelease];
				collection.displayName = [[collElem attributeForName:@"displayName"] stringValue];
				collection.hidden = [[[collElem attributeForName:@"hidden"] stringValue] boolValue];
				collection.internalName = [[collElem attributeForName:@"internalName"] stringValue];
				collection.desc = [[collElem attributeForName:@"description"] stringValue];
				
				NSMutableArray *fs = [NSMutableArray array];
				for (NSXMLElement *filterElem in [collElem elementsForName:@"FilterDescription"]) {
					BMFilter *filter = [filters objectForKey:[[filterElem attributeForName:@"internalName"] stringValue]];
					if (filter == nil) {@throw [NSException exceptionWithName:@"BMUnexpectedNilFilterException" reason:@"Filter should not be nil" userInfo:nil];}
					[fs addObject: filter];
				}
				collection.filters = [fs sortedArrayUsingSelector:@selector(compareAlphabetically:)];
				
				[collections addObject: collection];
			}
			
			filterGroup.filterCollections = [collections sortedArrayUsingSelector:@selector(compareAlphabetically:)];
			
			[groups addObject: filterGroup];
		}
		
		page.filterGroups = [groups sortedArrayUsingSelector:@selector(compareAlphabetically:)];
		
		[filterPages addObject: page];
	}
	self.dataset.filterPages = filterPages;
	self.dataset.filters = filters;
	
	NSArray *attribDescs = [doc nodesForXPath:@"//AttributeDescription" error:&error];
	if (error) {*err = error;return;}
	
	NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
	
	for (NSXMLElement *desc in attribDescs) {
		BMAttribute *attribute = [BMAttribute attribute];
		attribute.desc = [[desc attributeForName:@"description"] stringValue];
		attribute.displayName = [[desc attributeForName:@"displayName"] stringValue];
		attribute.field = [[desc attributeForName:@"field"] stringValue];
		attribute.internalName = [[desc attributeForName:@"internalName"] stringValue];
		attribute.isDefault = [[[desc attributeForName:@"isDefault"] stringValue] boolValue];
		attribute.key = [[desc attributeForName:@"key"] stringValue];
		attribute.linkoutURL = [[desc attributeForName:@"linkoutURL"] stringValue];
		attribute.maxLength = [[[desc attributeForName:@"maxLength"] stringValue] integerValue];
		attribute.tableConstraint = [[desc attributeForName:@"tableConstraint"] stringValue];
		
		[attributes setObject: attribute forKey: attribute.internalName];
	}
	
	NSMutableArray *attribPages = [NSMutableArray array];
	
	NSArray *attribPageDescs = [doc nodesForXPath:@"//AttributePage" error:&error];
	if (error) {*err = error;return;}
	for (NSXMLElement *desc in attribPageDescs) {
		BMAttributePage *page = [[[BMAttributePage alloc] init] autorelease];
		
		page.desc = [[desc attributeForName:@"description"] stringValue];
		page.displayName = [[desc attributeForName:@"displayName"] stringValue];
		page.internalName = [[desc attributeForName:@"internalName"] stringValue];
		page.outFormats = [[[desc attributeForName:@"outFormat"] stringValue] componentsSeparatedByString:@" "];
		
		NSMutableArray *groups = [NSMutableArray array];
		for (NSXMLElement *groupElem in [desc elementsForName:@"AttributeGroup"]) {
			BMAttributeGroup *attribGroup = [[[BMAttributeGroup alloc] init] autorelease];
			
			attribGroup.desc = [[groupElem attributeForName:@"description"] stringValue];
			attribGroup.displayName = [[groupElem attributeForName:@"displayName"] stringValue];
			attribGroup.internalName = [[groupElem attributeForName:@"internalName"] stringValue];
			
			NSMutableArray *collections = [NSMutableArray array];
			
			for (NSXMLElement *collElem in [groupElem elementsForName:@"AttributeCollection"]) {
				BMAttributeCollection *collection = [[[BMAttributeCollection alloc] init] autorelease];
				
				collection.desc = [[collElem attributeForName:@"description"] stringValue];
				collection.displayName = [[collElem attributeForName:@"displayName"] stringValue];
				collection.internalName = [[collElem attributeForName:@"internalName"] stringValue];
				
				NSMutableArray *as = [NSMutableArray array];
				for (NSXMLElement *attribElem in [collElem elementsForName:@"AttributeDescription"]) {
					BMAttribute *a = [attributes objectForKey:[[attribElem attributeForName:@"internalName"] stringValue]];
					if (a == nil) {@throw [NSException exceptionWithName:@"BMUnexpectedNilAttributeException" reason:@"Attribute should not be nil" userInfo:nil];}
					[as addObject: a];
				}
				collection.attributes = [as copy];
				
				[collections addObject: collection];
			}
			
			attribGroup.attributeCollections = [collections copy];
			
			[groups addObject: attribGroup];
		}
		
		page.attributeGroups = [groups copy];
		[attribPages addObject: page];
	}
	
	self.dataset.attributePages = attribPages;
	self.dataset.attributes = attributes;
	
	BMLog(@"%d filter pages (%d filters)",self.dataset.filterPages.count,[[self.dataset.filters allKeys] count]);
	BMLog(@"%@",self.dataset.filterPages);
	BMLog(@"%d attribute pages (%d attributes)", self.dataset.attributePages.count, [[self.dataset.attributes allKeys] count]);
	
}

-(void) parseOptions:(NSXMLElement*)optionElem forFilter:(BMFilter*)filter {
	BMOption *opt = [[[BMOption alloc] init] autorelease];
	opt.displayName = [[optionElem attributeForName:@"displayName"] stringValue];
	opt.displayType = [[optionElem attributeForName:@"displayType"] stringValue];
	opt.field = [[optionElem attributeForName:@"field"] stringValue];
	opt.hidden = [[[optionElem attributeForName:@"hidden"] stringValue] boolValue];
	opt.internalName = [[optionElem attributeForName:@"internalName"] stringValue];
	opt.isSelectable = [[[optionElem attributeForName:@"isSelectable"] stringValue] boolValue];
	opt.key = [[optionElem attributeForName:@"key"] stringValue];
	opt.legalQualifiers = [[[optionElem attributeForName:@"legalQualifiers"] stringValue] componentsSeparatedByString:@" "];
	opt.qualifier = [[optionElem attributeForName:@"qualifier"] stringValue];
	opt.style = [[optionElem attributeForName:@"style"] stringValue];
	opt.tableConstraint = [[optionElem attributeForName:@"tableConstraint"] stringValue];
	opt.type = [[optionElem attributeForName:@"type"] stringValue];
	
	[filter.options addObject: opt];
	
	for (NSXMLElement *elem in [optionElem elementsForName:@"Option"]) {
		[self parseOptions:elem forFilter: filter];
	}
}

//=========================================================== 
// dealloc
//=========================================================== 
- (void)dealloc
{
    [_dataset release], _dataset = nil;
    [_document release], _document = nil;
    [_error release], _error = nil;
	
    [super dealloc];
}



@end
