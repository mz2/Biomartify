//
//  BMQuery.m
//  biomartify
//
//  Created by Matias Piipari on 07/05/2010.
//  Copyright 2010 Wellcome Trust Sanger Institute. All rights reserved.
//

#import "BMQuery.h"
#import "BMart.h"
#import "BMDataset.h"
#import "BMartService.h"

@implementation BMQuery
@synthesize virtualSchemaName = _virtualSchemaName;
@synthesize formatter = _formatter;
@synthesize header = _header;
@synthesize uniqueRows = _uniqueRows;
@synthesize count = _count;
@synthesize datasetConfigVersion = _datasetConfigVersion;
@synthesize dataset = _dataset;
@synthesize mart = _mart;

//=========================================================== 
// - (id)init
//
//=========================================================== 
- (id)init
{
    if (self = [super init]) {
        [self setVirtualSchemaName: @"default"];
        [self setFormatter: nil];
        [self setHeader: NO];
        [self setUniqueRows: NO];
        [self setCount: 0];
        [self setDatasetConfigVersion: @"0.6"];
		_dataset = nil;
    }
    return self;
}


//=========================================================== 
// - (id)initWith:
//
//=========================================================== 
- (id)initWithVirtualSchemaName:(NSString*)aVirtualSchemaName 
					  formatter:(NSString*)aFormatter 
						 header:(BOOL)header 
					 uniqueRows:(BOOL)uniqueRows
						  count:(NSUInteger)aCount 
		   datasetConfigVersion:(NSString*)aDatasetConfigVersion {
    if (self = [super init]) {
        [self setVirtualSchemaName:aVirtualSchemaName];
        [self setFormatter:aFormatter];
        [self setHeader:header];
        [self setUniqueRows:uniqueRows];
        [self setCount:aCount];
        [self setDatasetConfigVersion:aDatasetConfigVersion];    }
    return self;
}


//=========================================================== 
// + (id)objectWith:
//
//=========================================================== 
+ (id)queryWithVirtualSchemaName:(NSString*)aVirtualSchemaName 
					   formatter:(NSString*)aFormatter 
						  header:(BOOL)header 
					  uniqueRows:(BOOL)uniqueRows
						   count:(NSUInteger)aCount 
			datasetConfigVersion:(NSString*)aDatasetConfigVersion {
    id result = [[[self class] alloc] initWithVirtualSchemaName:aVirtualSchemaName 
													  formatter:aFormatter
														 header:header 
													 uniqueRows:uniqueRows 
														  count:aCount 
										   datasetConfigVersion:aDatasetConfigVersion];
	
    return [result autorelease];
}

+(id) query {
	return [[[[self class] alloc] init] autorelease];
}

//=========================================================== 
// dealloc
//=========================================================== 
- (void)dealloc
{
    [_virtualSchemaName release], _virtualSchemaName = nil;
    [_formatter release], _formatter = nil;
    [_datasetConfigVersion release], _datasetConfigVersion = nil;
    [_dataset release], _dataset = nil;
	
    [super dealloc];
}

-(void) setMart:(BMart *) mart {
	BMLog(@"Setting query mart to %@", mart);
	[self willChangeValueForKey: @"mart"];
	
	[mart retain];
	[_mart release];
	_mart = mart;
	
	if (self.mart != nil) {
		if (![self.mart.datasets containsObject: self.dataset]) {
			BMLog(@"Dataset %@ is not contained by mart %@", self.dataset, self.mart);
			self.dataset = nil;
		}

		if (self.dataset == nil) {
			BMLog(@"Will request datasets for mart %@", self.mart);
			[[BMartService sharedMartService] requestDatasetsForMart: self.mart];
		}
	} else {
		self.dataset = nil;
	}
	
	[self didChangeValueForKey: @"mart"];
}

-(void) setDataset:(BMDataset*) dataset {
	BMLog(@"Setting query dataset to %@", dataset);
	[self willChangeValueForKey:@"dataset"];
	
	[dataset retain];
	[_dataset release];
	_dataset = dataset;
	
	if (self.dataset != nil) {
		
		if (self.dataset.attributes == nil) {
			BMLog(@"Will request attributes for dataset %@", self.dataset);
			[[BMartService sharedMartService] requestAttributesForDataset: self.dataset];
		}
		
		if (self.dataset.filters == nil) {
			BMLog(@"Will request filters for dataset %@", self.dataset);
			[[BMartService sharedMartService] requestFiltersForDataset: self.dataset];
		}
	}
	
	[self didChangeValueForKey:@"dataset"];
}

@end
