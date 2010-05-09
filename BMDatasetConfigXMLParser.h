//
//  BMDatasetConfigXMLParser.h
//  Biomartify
//
//  Created by Matias Piipari on 09/05/2010.
//  Copyright 2010 Wellcome Trust Sanger Institute. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class BMDataset;

@interface BMDatasetConfigXMLParser : NSObject {
	
@protected
	BMDataset *_dataset;
	
	NSXMLDocument *_document;
    NSError *_error;
}

@property(nonatomic,retain)BMDataset *dataset;
@property(nonatomic,retain)NSError *error;


- (id)initWithData:(NSData*) data dataset:(BMDataset*)dataset;
@end
