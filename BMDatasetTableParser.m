//
//  BMDatasetXMLParser.m
//  biomartify
//
//  Created by Matias Piipari on 08/05/2010.
//  Copyright 2010 Wellcome Trust Sanger Institute. All rights reserved.
//

#import "BMDatasetTableParser.h"
#import "CSVParser.h"
#import "BMDataset.h"

@implementation BMDatasetTableParser
@synthesize datasets = _datasets;
@synthesize error = _error;

- (id)initWithString:(NSString*) str
{
    if (self = [super init]) {
		_datasets = [[NSMutableArray alloc] init];
        CSVParser *parser = [[[CSVParser alloc] initWithString:str 
										  separator:@"\t" 
										  hasHeader:NO 
										 fieldNames:[NSArray arrayWithObjects:@"TableSet",@"name", @"displayName", @"visible",@"field4",@"field5",@"field6",@"interface",@"date",nil]] autorelease];
		
		[parser parseRowsForReceiver:self selector:@selector(parseRecord:)];
		
    }
    return self;
}

-(void) parseRecord:(NSDictionary*) record {
	BMDataset *dataset = [BMDataset dataset];
	
	if ([record objectForKey:@"name"] == nil) return;
	
	dataset.name = [record objectForKey:@"name"];
	dataset.displayName = [record objectForKey:@"displayName"];
	dataset.visible = [[record objectForKey:@"visible"] boolValue];
	dataset.interface = [record objectForKey:@"interface"];
	
	[_datasets addObject: dataset];
}

-(void) dealloc {
	[_datasets release], _datasets = nil;
	[_parser release], _parser = nil;
    [_error release], _error = nil;
    [super dealloc];
}


@end
