//
//  BMRegistry.h
//  Biomartify
//
//  Created by Matias Piipari on 07/05/2010.
//  Copyright 2010 Wellcome Trust Sanger Institute. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface BMRegistry : NSObject {
	NSURL *_url;
	NSMutableArray *_marts;
}

@property(nonatomic,retain)NSURL *url;
@property(nonatomic,retain)NSMutableArray *marts;

@end
