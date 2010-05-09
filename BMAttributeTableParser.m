//
//  BMAttributeTableParser.m
//  Biomartify
//
//  Created by Matias Piipari on 09/05/2010.
//  Copyright 2010 Wellcome Trust Sanger Institute. All rights reserved.
//

#import "BMAttributeTableParser.h"
#import "CSVParser.h"
#import "BMDataset.h"
#import "BMAttribute.h"

@implementation BMAttributeTableParser
@synthesize attributes = _attributes;
@synthesize error = _error;

- (id)initWithString:(NSString*) str
{
    if (self = [super init]) {
		_attributes = [[NSMutableArray alloc] init];
        CSVParser *parser = [[[CSVParser alloc] initWithString:str 
													 separator:@"\t" 
													 hasHeader:NO 
													fieldNames:[NSArray arrayWithObjects:@"TableSet",@"name", @"displayName", @"visible",@"field4",@"field5",@"field6",@"interface",@"date",nil]] autorelease];
		
		[parser parseRowsForReceiver:self selector:@selector(parseRecord:)];
		
    }
    return self;
}

-(void) parseRecord:(NSDictionary*) record {
	BMAttribute *attrib = [BMAttribute attribute];
	
	if ([record objectForKey:@"name"] == nil) return;
	
	attrib.name = [record objectForKey:@"name"];
	
	[_attributes addObject: attrib];
}

-(void) dealloc {
	[_attributes release], _attributes = nil;
	[_parser release], _parser = nil;
    [_error release], _error = nil;
    [super dealloc];
}


@end
