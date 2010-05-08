//
//  BMDataset.m
//  Biomartify
//
//  Created by Matias Piipari on 07/05/2010.
//  Copyright 2010 Wellcome Trust Sanger Institute. All rights reserved.
//

#import "BMDataset.h"


@implementation BMDataset

@synthesize name = _name;
@synthesize interface = _interface;
@synthesize filters = _filters;
@synthesize attributes = _attributes;

//=========================================================== 
// - (id)init
//
//=========================================================== 
- (id)init
{
    if (self = [super init]) {
        [self setName: nil];
        [self setInterface: @"default"];
        _filters = [[NSMutableArray alloc] init];
        _attributes = [[NSMutableArray alloc] init];
    }
    return self;
}


//=========================================================== 
// - (id)initWith:
//
//=========================================================== 
- (id)initWithName:(NSString*)aName 
		 interface:(NSString*)anInterface 
{
    if (self = [super init]) {
        [self setName:aName];
        [self setInterface:anInterface];
        _filters = [[NSMutableArray alloc] init];
        _attributes = [[NSMutableArray alloc] init];
    }
    return self;
}


//=========================================================== 
// + (id)objectWith:
//
//=========================================================== 
+ (id)datasetWithName:(NSString*)aName 
			interface:(NSString*)anInterface
{
    id result = [[[self class] alloc] initWithName:aName 
										 interface:anInterface];
	
    return [result autorelease];
}

+ (id) dataset {
	return [[[[self class] alloc] init] autorelease];
}

//=========================================================== 
// dealloc
//=========================================================== 
- (void)dealloc
{
    [_name release], _name = nil;
    [_interface release], _interface = nil;
    [_filters release], _filters = nil;
    [_attributes release], _attributes = nil;
	
    [super dealloc];
}


@end
