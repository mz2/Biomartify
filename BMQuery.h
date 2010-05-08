//
//  BMQuery.h
//  biomartify
//
//  Created by Matias Piipari on 07/05/2010.
//  Copyright 2010 Wellcome Trust Sanger Institute. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class BMDataset;

@interface BMQuery : NSObject {
	NSString *_virtualSchemaName;
	NSString *_formatter;
	BOOL _header;
	BOOL _uniqueRows;
	NSUInteger _count;
	NSString *_datasetConfigVersion;
	
	BMDataset *_dataset;
}

@property(nonatomic,copy)NSString *virtualSchemaName;
@property(nonatomic,copy)NSString *formatter;
@property(nonatomic,assign)BOOL header;
@property(nonatomic,assign)BOOL uniqueRows;
@property(nonatomic,assign)NSUInteger count;
@property(nonatomic,copy)NSString *datasetConfigVersion;
@property(nonatomic,retain)BMDataset *dataset;

- (id)initWithVirtualSchemaName:(NSString*)aVirtualSchemaName 
					  formatter:(NSString*)aFormatter 
						 header:(BOOL)flag 
					 uniqueRows:(BOOL)flag 
						  count:(NSUInteger)aCount 
		   datasetConfigVersion:(NSString*)aDatasetConfigVersion;

+ (id)queryWithVirtualSchemaName:(NSString*)aVirtualSchemaName 
					   formatter:(NSString*)aFormatter 
						  header:(BOOL)flag uniqueRows:(BOOL)flag
						   count:(NSUInteger)aCount 
			datasetConfigVersion:(NSString*)aDatasetConfigVersion;
+(id) query;
@end
