//
//  BMFilterTableParser.m
//  Biomartify
//
//  Created by Matias Piipari on 09/05/2010.
//  Copyright 2010 Wellcome Trust Sanger Institute. All rights reserved.
//

#import "BMFilterTableParser.h"
#import "CSVParser.h"
#import "BMDataset.h"
#import "BMFilter.h"

@implementation BMFilterTableParser
@synthesize filters = _filters;
@synthesize error = _error;

- (id)initWithString:(NSString*) str
{
    if (self = [super init]) {
		_filters = [[NSMutableArray alloc] init];
        CSVParser *parser = [[[CSVParser alloc] initWithString:str 
													 separator:@"\t" 
													 hasHeader:NO 
													fieldNames:[NSArray arrayWithObjects:@"TableSet",@"name", @"displayName", @"visible",@"field4",@"field5",@"field6",@"interface",@"date",nil]] autorelease];
		
		[parser parseRowsForReceiver:self selector:@selector(parseRecord:)];
		
    }
    return self;
}

-(void) parseRecord:(NSDictionary*) record {
	BMFilter *filter = [BMFilter filter];
	
	if ([record objectForKey:@"name"] == nil) return;
	
	filter.internalName = [record objectForKey:@"internalName"];
	
	[_filters addObject: filter];
}

-(void) dealloc {
	[_filters release], _filters = nil;
	[_parser release], _parser = nil;
    [_error release], _error = nil;
    [super dealloc];
}


@end
