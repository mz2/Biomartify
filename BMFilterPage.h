//
//  BMFilterPage.h
//  Biomartify
//
//  Created by Matias Piipari on 09/05/2010.
//  Copyright 2010 Wellcome Trust Sanger Institute. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface BMFilterPage : NSObject {
	NSArray *_filterGroups;
	BOOL _hideDisplay;
	NSString *_internalName;
	NSString *_displayName;
}

@property(nonatomic,retain)NSArray *filterGroups;
@property(nonatomic,assign)BOOL hideDisplay;
@property(nonatomic,copy)NSString *internalName;
@property(nonatomic,retain)NSString *displayName;
@end
