//
//  BMQueryXMLParser.h
//  Biomartify
//
//  Created by Matias Piipari on 07/05/2010.
//  Copyright 2010 Wellcome Trust Sanger Institute. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class BMQuery;

@interface BMQueryXMLParser : NSObject {
	BMQuery *_query;
	
	@protected
	NSXMLParser *_parser;
    NSError *_error;
	
}

@property(nonatomic,retain,readonly)BMQuery *query;
@property(nonatomic,retain,readonly)NSError *error;

- (id)initWithData:(NSData*) data;
+ (id)parserWithData:(NSData*)aData;
@end
