//
//  BMDataset.h
//  Biomartify
//
//  Created by Matias Piipari on 07/05/2010.
//  Copyright 2010 Wellcome Trust Sanger Institute. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "BMFilter.h"
#import "BMAttribute.h"

@interface BMDataset : NSObject {
	NSString *_name;
	NSString *_interface;
	
	NSMutableArray *_filters;
	NSMutableArray *_attributes;
}

@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *interface;

@property(nonatomic,retain,readonly)NSArray *filters;
@property(nonatomic,retain,readonly)NSArray *attributes;

- (id)initWithName:(NSString*)aName 
		 interface:(NSString*)anInterface;

+ (id)datasetWithName:(NSString*)aName
			interface:(NSString*)anInterface;

+ (id)dataset;

@end