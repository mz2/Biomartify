//
//  BMAttributeTableParser.h
//  Biomartify
//
//  Created by Matias Piipari on 09/05/2010.
//  Copyright 2010 Wellcome Trust Sanger Institute. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class CSVParser;

@interface BMAttributeTableParser : NSObject {
	NSMutableArray *_attributes;
	
@protected
	CSVParser *_parser;
	NSError *_error;
}

@property(nonatomic,retain)NSArray *attributes;
@property(nonatomic,retain)NSError *error;


@end
