//
//  BMQueryDocument.h
//  Biomartify
//
//  Created by Matias Piipari on 07/05/2010.
//  Copyright 2010 Wellcome Trust Sanger Institute. All rights reserved.
//


#import <Cocoa/Cocoa.h>

@class BMRegistry;
@class BMQuery;

@interface BMQueryDocument : NSDocument
{
	BMQuery *_query;
	BMRegistry *_registry;
	
	NSArrayController *_martListController;
	
	NSArray *_treeSelectionIndexPaths;
}

@property(nonatomic,retain) IBOutlet BMQuery *query;
@property(nonatomic,retain) BMRegistry *registry;
@property(nonatomic,retain) IBOutlet NSArrayController *martListController;

@property(nonatomic,retain) NSArray *treeSelectionIndexPaths;

-(IBAction) runQuery:(id) sender;
-(IBAction) addFilter:(id) sender;
-(IBAction) addAttribute:(id) sender;
@end
