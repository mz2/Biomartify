//
//  BMQueryXMLParser.m
//  Biomartify
//
//  Created by Matias Piipari on 07/05/2010.
//  Copyright 2010 Wellcome Trust Sanger Institute. All rights reserved.
//

#import "BMQueryXMLParser.h"
#import "BMQuery.h"
#import "BMDataset.h"

@implementation BMQueryXMLParser
@synthesize query = _query;
@synthesize error = _error;

//=========================================================== 
// - (id)init
//
//=========================================================== 
- (id)initWithData:(NSData*) data
{
    if (self = [super init]) {
        _parser = [[NSXMLParser alloc] initWithData: data];
		_parser.delegate = self;
		
		_query = [[BMQuery alloc] init];
		
		if (![_parser parse]) {
			BMLog(@"Parsing failed");
			_error = [[_parser parserError] retain];
		} else {
			BMLog(@"Parsing succeeded");
		}
    }
    return self;
}

//=========================================================== 
// + (id)objectWith:
//
//=========================================================== 
+ (id)parserWithData:(NSData*)aData  
{
    id result = [[[self class] alloc] initWithData:aData];
    return [result autorelease];
}


//=========================================================== 
// dealloc
//=========================================================== 
- (void)dealloc
{
	[_query release], _query = nil;
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
    
    if ([elementName isEqualToString:@"Query"]) {
		
        _query = [[BMQuery alloc] initWithVirtualSchemaName:[attributeDict objectForKey:@"virtualSchemaName"] 
												  formatter:[attributeDict objectForKey:@"formatter"] 
													 header:[[attributeDict objectForKey:@"header"] boolValue] 
												 uniqueRows:[[attributeDict objectForKey:@"uniqueRows"] boolValue] 
													  count:(NSUInteger)[[attributeDict objectForKey:@"count"] integerValue] 
									   datasetConfigVersion:[attributeDict objectForKey:@"datasetConfigVersion"]];
    }
    
    if([elementName isEqualToString:@"Dataset"]) {
        _query.dataset = [BMDataset datasetWithName:[attributeDict objectForKey:@"name"] 
										  interface:[attributeDict objectForKey:@"interface"]];
    }
}

/*
- (void)parser:(NSXMLParser *)parser 
 didEndElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:@"WhatgasFeed"]) {
        return;
    }
    [_elementNameStack removeLastObject];
    //PCLog(@"Element name stack: %@ = %@",elementNameStack, elementName);
    NSParameterAssert(station != nil);
    
    if ([elementName isEqualToString:@"StationName"]) {
        station.name = currentElementValue;
    } else if ([elementName isEqualToString:@"Postcode"]) {
        station.postcode = currentElementValue;
    } else if ([elementName isEqualToString:@"Phone"]) {
        station.phone = currentElementValue;
    } else if ([elementName isEqualToString:@"Lat"]) {
        latitude = (CLLocationDegrees)[currentElementValue doubleValue];
    } else if ([elementName isEqualToString:@"Long"]) {
        longitude = (CLLocationDegrees)[currentElementValue doubleValue];
    } else if ([elementName isEqualToString:@"Brand"]) {
        station.brand = currentElementValue;
    } else if ([elementName isEqualToString:@"Units"]) {
        station.units = currentElementValue;
    } else if ([elementName isEqualToString:@"Town"]) {
        station.town = currentElementValue;
    } else if ([elementName isEqualToString:@"AvgRating"]) {
		station.avgRating = [currentElementValue intValue];
	} else if ([elementName isEqualToString:@"RatingCount"]) {
		station.ratingCount = [currentElementValue intValue];
	} else if ([elementName isEqualToString:@"Station"]) {
        station.location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
        [stations addObject: station];
        [station release];
        station = nil;
    }
    ///Children of /WhatgasFeed/Station/Price (Fuel | Price | Date)
    else if ([elementName isEqualToString:@"Fuel"] && 
			 [[elementNameStack lastObject] isEqualToString:@"Price"]) {
        price.fuel = [currentElementValue retain];
    } 
    else if ([elementName isEqualToString:@"FuelIDX"]) {
        price.fuelID = [currentElementValue intValue];
    }
    else if ([elementName isEqualToString:@"Date"] &&
			 [[elementNameStack lastObject] isEqualToString:@"Price"]) {
        price.date = [dateFormatter dateFromString:currentElementValue];
    } else if ([elementName isEqualToString:@"FuelOrder"]) {
		price.sortOrder = [currentElementValue intValue];
	} else if ([elementName isEqualToString:@"Price"] &&
               [[elementNameStack lastObject] isEqualToString:@"Price"]) {
        [price setPrice: (NSDecimalNumber*)[priceFormatter numberFromString: currentElementValue]]; //en_US localisation is assumed for the price value
    }
    // /WhatgasFeed/Station/Price
    else if ([elementName isEqualToString:@"Price"] &&
			 ![[elementNameStack lastObject] isEqualToString:@"Price"]) {
        NSParameterAssert(price != nil);
        [station.prices addObject: price];
        price.station = station;
    }
    
    [currentElementValue release];
    currentElementValue = nil;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    //PCLog(@"Found characters '%@' (#%d)", string,[string length]);
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] > 0) {
        if (currentElementValue == nil) {
            currentElementValue = [[NSMutableString alloc] initWithString: string];        
        } else {
            [currentElementValue appendString: string];
        }        
    }
}*/


- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    if (parseError != nil) {
        BMLog(@"Parsing error occurred: %@", [parseError description]);
    }
}


- (void)parserDidEndDocument:(NSXMLParser *)p {
	BMLog(@"Ended parsing document");
	NSLog(@"Parsed");
}

@end
