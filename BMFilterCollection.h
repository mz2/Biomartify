//
//  BMFilterCollection.h
//  Biomartify
//
//  Created by Matias Piipari on 09/05/2010.
//  Copyright 2010 Wellcome Trust Sanger Institute. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface BMFilterCollection : NSObject {
	NSString *_displayName;
	NSString *_desc;
	BOOL _hidden;
	NSString *_internalName;
	
	NSArray *_filters;
}

@property(nonatomic,copy)NSString *displayName;
@property(nonatomic,copy)NSString *desc;
@property(nonatomic,assign)BOOL hidden;
@property(nonatomic,copy)NSString *internalName;
@property(nonatomic,retain)NSArray *filters;

@end
