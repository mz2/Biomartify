//
//  BMDatasetXMLParser.h
//  biomartify
//
//  Created by Matias Piipari on 08/05/2010.
//  Copyright 2010 Wellcome Trust Sanger Institute. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class CSVParser;

@interface BMDatasetTableParser : NSObject {
	NSMutableArray *_datasets;
	
	@protected
	CSVParser *_parser;
	NSError *_error;
}

@property(nonatomic,retain)NSArray *datasets;
@property(nonatomic,retain)NSError *error;

@end
