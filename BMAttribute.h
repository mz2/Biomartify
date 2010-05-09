//
//  BMAttribute.h
//  Biomartify
//
//  Created by Matias Piipari on 07/05/2010.
//  Copyright 2010 Wellcome Trust Sanger Institute. All rights reserved.
//

#import <Cocoa/Cocoa.h>
/*
default="true" 
description="Ensembl Stable ID of the Gene" 
displayName="Ensembl Gene ID" 
field="stable_id_1023" 
internalName="ensembl_gene_id" 
key="gene_id_1020_key" 
linkoutURL="exturl|/Ornithorhynchus_anatinus/Gene/Summary?db=core;g=%s" 
maxLength="15" 
tableConstraint="main
*/
@interface BMAttribute : NSObject {
	BOOL _isDefault;
	NSString *_desc;
	NSString *_displayName;
	NSString *_field;
	NSString *_internalName;
	NSString *_key;
	NSString *_linkoutURL;
	NSUInteger _maxLength;
	NSString *_tableConstraint;
}

@property(nonatomic,assign)BOOL isDefault;
@property(nonatomic,copy)NSString *desc;
@property(nonatomic,copy)NSString *displayName;
@property(nonatomic,copy)NSString *field;
@property(nonatomic,copy)NSString *internalName;
@property(nonatomic,copy)NSString *key;
@property(nonatomic,copy)NSString *linkoutURL;
@property(nonatomic,assign)NSUInteger maxLength;
@property(nonatomic,copy)NSString *tableConstraint;

+(id) attribute;

@end
