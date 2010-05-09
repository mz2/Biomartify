//
//  BMFilter.h
//  Biomartify
//
//  Created by Matias Piipari on 07/05/2010.
//  Copyright 2010 Wellcome Trust Sanger Institute. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface BMFilter : NSObject {
	NSString *_internalName;
	NSString *_displayName;
	NSString *_displayType;
	BOOL _hidden;
	NSString *_type;
	NSMutableArray *_options;
}

@property(nonatomic,copy)NSString *internalName;
@property(nonatomic,copy)NSString *displayName;
@property(nonatomic,copy)NSString *displayType;
@property(nonatomic,assign)BOOL hidden;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,retain)NSMutableArray *options;

+(id) filter;

@end
