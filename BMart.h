//
//  BMart.h
//  Biomartify
//
//  Created by Matias Piipari on 07/05/2010.
//  Copyright 2010 Wellcome Trust Sanger Institute. All rights reserved.
//

#import <Cocoa/Cocoa.h>


//<MartURLLocation database="ensembl_mart_57" 
//default="1" displayName="ENSEMBL GENES 57 (SANGER UK)" 
//host="www.biomart.org" includeDatasets="" 
//martUser="" name="ensembl" path="/biomart/martservice" port="80" serverVirtualSchema="default" visible="1" />
@interface BMart : NSObject {
	NSString *_database;
	BOOL _isDefault;
	NSString *_displayName;
	NSString *_host;
	NSArray *_includeDatasets;
	NSString *_martUser;
	NSString *_name;
	NSString *_path;
	NSUInteger _port;
	NSString *_serverVirtualSchema;
	BOOL _visible;
}

@property(nonatomic,copy)NSString *database;
@property(nonatomic,assign)BOOL isDefault;
@property(nonatomic,copy)NSString *displayName;
@property(nonatomic,copy)NSString *host;
@property(nonatomic,retain)NSArray *includeDatasets;
@property(nonatomic,copy)NSString *martUser;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *path;
@property(nonatomic,assign)NSUInteger port;
@property(nonatomic,copy)NSString *serverVirtualSchema;
@property(nonatomic,assign)BOOL visible;

@end
