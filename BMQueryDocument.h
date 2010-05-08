//
//  MyDocument.h
//  Biomartify
//
//  Created by Matias Piipari on 07/05/2010.
//  Copyright 2010 Wellcome Trust Sanger Institute. All rights reserved.
//


#import <Cocoa/Cocoa.h>
@class BMQuery;

@interface BMQueryDocument : NSDocument
{
	BMQuery *_query;
}
@property(nonatomic,retain)BMQuery *query;
@end
