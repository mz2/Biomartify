//
//  BMAttributeGroup.h
//  Biomartify
//
//  Created by Matias Piipari on 09/05/2010.
//  Copyright 2010 Wellcome Trust Sanger Institute. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface BMAttributeGroup : NSObject {
	NSString *_desc;
	NSString *_displayName;
	NSString *_internalName;
	
	NSArray *_attributeCollections;
}

@property(nonatomic,copy)NSString *desc;
@property(nonatomic,copy)NSString *displayName;
@property(nonatomic,copy)NSString *internalName;
@property(nonatomic,retain)NSArray *attributeCollections;

@end
