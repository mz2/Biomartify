//
//  BMRegistryXMLParser.h
//  Biomartify
//
//  Created by Matias Piipari on 07/05/2010.
//  Copyright 2010 Wellcome Trust Sanger Institute. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class BMRegistry;
@class BMQuery;

@interface BMRegistryXMLParser : NSObject {

@protected
	BMRegistry *_registry;
	NSXMLParser *_parser;
    NSError *_error;
}
@property(nonatomic,retain,readonly)BMRegistry *registry;
@property(nonatomic,retain,readonly)NSError *error;

+ (id)parserWithData:(NSData*)aData;
@end
