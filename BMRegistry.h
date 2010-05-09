//
//  BMRegistry.h
//  Biomartify
//
//  Created by Matias Piipari on 07/05/2010.
//  Copyright 2010 Wellcome Trust Sanger Institute. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class BMart;

@interface BMRegistry : NSObject {
	NSURL *_url;
	NSMutableArray *_marts;
	NSMutableDictionary *_martsByName;
	
}

@property(nonatomic,retain)NSURL *url;
@property(nonatomic,retain)NSMutableArray *marts;
@property(nonatomic,retain,readonly)NSDictionary *martsByName;
@property(nonatomic,retain,readonly)NSArray *visibleMarts;

-(BMart*) martWithName:(NSString*) name;

-(NSImage*) icon;
@end
