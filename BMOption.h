//
//  BMOption.h
//  Biomartify
//
//  Created by Matias Piipari on 09/05/2010.
//  Copyright 2010 Wellcome Trust Sanger Institute. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface BMOption : NSObject {
	NSString *_displayName;
	NSString *_displayType;
	NSString *_field;
	BOOL _hidden;
	NSString *_internalName;
	BOOL _isSelectable;
	NSString *_key;
	NSArray *_legalQualifiers;
	NSString *_qualifier;
	NSString *_style;
	NSString *_tableConstraint;
	NSString *_type;
	
	NSArray *_options;
}

@property(nonatomic,copy)NSString *displayName;
@property(nonatomic,copy)NSString *displayType;
@property(nonatomic,copy)NSString *field;
@property(nonatomic,assign)BOOL hidden;
@property(nonatomic,copy)NSString *internalName;
@property(nonatomic,assign)BOOL isSelectable;
@property(nonatomic,copy)NSString *key;
@property(nonatomic,retain)NSArray *legalQualifiers;
@property(nonatomic,copy)NSString *qualifier;
@property(nonatomic,copy)NSString *style;
@property(nonatomic,copy)NSString *tableConstraint;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,retain)NSArray *options;

@end
