//
//  BMRegistryXMLParser.m
//  Biomartify
//
//  Created by Matias Piipari on 07/05/2010.
//  Copyright 2010 Wellcome Trust Sanger Institute. All rights reserved.
//

#import "BMRegistryXMLParser.h"


@implementation BMRegistryXMLParser
@synthesize registry=_registry;

- (id)initWithData:(NSData*) data
{
    if (self = [super init]) {
        _parser = [[NSXMLParser alloc] initWithData: data];
		_parser.delegate = self;
		_registry = [[BMRegistry alloc] init];
		
		if (![_parser parse]) {
			BMLog(@"Parsing failed");
			_error = [[_parser parserError] retain];
		} else {
			BMLog(@"Parsing succeeded");
		}
    }
    return self;
}

+ (id)parserWithData:(NSData*)aData  
{
    id result = [[[self class] alloc] initWithData:aData];
    return [result autorelease];
}


-(void) dealloc {
	[_registry release], _registry = nil;
    [_parser release], _parser = nil;
	[_error release], _error = nil;
    [super dealloc];
}

#pragma mark NSXMLParserDelegate

- (void) parser:(NSXMLParser *)parser 
didStartElement:(NSString *)elementName
   namespaceURI:(NSString *)namespaceURI 
  qualifiedName:(NSString *)qualifiedName
     attributes:(NSDictionary *)attributeDict {
    //PCLog(@"Start:%@",elementName);
    
    if ([elementName isEqualToString:@"Registry"]) {
		
        _registry = [[BMRegistry alloc] init];
    }
    
    if([elementName isEqualToString:@"MartURLLocation"]) {
		BMart *mart = [[BMart alloc] initWithDatabase:[attributeDict objectForKey:@"database"] 
											isDefault:[attributeDict objectForKey:@"default"] 
										  displayName:[attributeDict objectForKey:@"displayName"]
												 host:[attributeDict objectForKey:@"host"]
									  includeDatasets:[[attributeDict objectForKey:@"includeDatasets"] componentsSeparatedByString:@" "]
											 martUser:[attributeDict objectForKey:@"martUser"]
												 name:[attributeDict objectForKey:@"name"]
												 path:[attributeDict objectForKey:@"path"]
												 port:[attributeDict objectForKey:@"port"]
								  serverVirtualSchema:[attributeDict objectForKey:@"serverVirtualSchema"]
											  visible:[attributeDict objectForKey:@"visible"]
		[_registry.marts addObject: 
    }
}

@end
