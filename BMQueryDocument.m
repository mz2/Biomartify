//
//  BMQueryDocument.m
//  Biomartify
//
//  Created by Matias Piipari on 07/05/2010.
//  Copyright 2010 Wellcome Trust Sanger Institute. All rights reserved.
//

#import "BMQueryDocument.h"
#import "BMQueryXMLParser.h"
#import "BMRegistry.h"
#import "BMQuery.h"
#import "BMart.h"

@implementation BMQueryDocument
@synthesize query = _query;
@synthesize registry = _registry;
@synthesize martListController = _martListController;
@synthesize treeSelectionIndexPaths = _treeSelectionIndexPaths;

- (id)init
{
    self = [super init];
    if (self) {
        // Add your subclass-specific initialization here.
        // If an error occurs here, send a [self release] message and return nil.
		[[NSNotificationCenter defaultCenter] addObserver: self
												 selector: @selector(registryReceived:)
													 name: BMRegistryReceivedNotification 
												   object: nil];
		
		[[NSNotificationCenter defaultCenter] addObserver: self
												 selector: @selector(registryRequestFailed:)
													 name: BMRegistryRequestFailedNotification
												   object: nil];
		
		[[NSNotificationCenter defaultCenter] addObserver: self
												 selector: @selector(receivedDatasetsForMart:)
													 name: BMartReceivedDatasetsForMartNotification
												   object: nil];
				
		[[NSNotificationCenter defaultCenter] addObserver: self
												 selector: @selector(failedToReceiveDatasetsForMart:)
													 name: BMartRequestDatasetsForMartFailedNotification
												   object: nil];
		
		[[NSNotificationCenter defaultCenter] addObserver: self
												 selector: @selector(receivedConfigurationForDataset:)
													 name: BMartReceivedDatasetConfigurationForDataset
												   object: nil];
		
		[[NSNotificationCenter defaultCenter] addObserver: self
												 selector: @selector(failedToReceiveConfigurationForDataset:)
													 name: BMartRequestDatasetConfigurationForMartFailedNotification
												   object: nil];
		/*
		[self addObserver: self 
			   forKeyPath: @"query.mart" 
				  options: NSKeyValueObservingOptionNew 
				  context: nil];
		 */
    }
    return self;
}

/*
-(void) observeValueForKeyPath:(NSString *)keyPath 
					  ofObject:(id)object 
						change:(NSDictionary *)change
					   context:(void *)context {
	if ([keyPath isEqual:@"query.mart"]) {
		BMLog(@"query.mart: %@, change: %@", keyPath, change);
		
		//self.query.mart = [change objectForKey:NSKeyValueChangeNewKey];
		//[self setValue:[change objectForKey:NSKeyValueChangeNewKey] forKey:keyPath];
	}
	
	[super observeValueForKeyPath:keyPath
						 ofObject:object
						   change:change
						  context:context];
}*/

-(void) setTreeSelectionIndexPaths:(NSArray*) indexPaths {
	BMLog(@"Selection index paths:%@", indexPaths);
	[self willChangeValueForKey:@"treeSelectionIndexPaths"];
	[_treeSelectionIndexPaths retain];
	[_treeSelectionIndexPaths release];
	_treeSelectionIndexPaths = indexPaths;
	
	if (_treeSelectionIndexPaths.count > 0) {
		NSIndexPath *indexPath = [_treeSelectionIndexPaths objectAtIndex:0];
		
		if (indexPath.length > 0) {
			if (indexPath.length == 1) {
				BMart *mart = [self.registry.marts objectAtIndex: [indexPath indexAtPosition:0]];
				self.query.mart = mart;
			} else if (indexPath.length == 2) {
				BMart *mart = [self.registry.marts objectAtIndex: [indexPath indexAtPosition: 0]];
				self.query.dataset = [mart.datasets objectAtIndex:[indexPath indexAtPosition: 1]]; 
			}
		}		
	} 
	
	[self didChangeValueForKey:@"treeSelectionIndexPaths"];
}

-(void) dealloc {
	[_query release], _query = nil;
	[_registry release], _registry = nil;
	
	[super dealloc];
}

-(void) registryReceived:(NSNotification*) notification {
	BMLog(@"New registry received");
	self.registry = (BMRegistry*)[notification object];
	
	if (self.query.mart != nil) {
		
	}
}

-(void) registryRequestFailed:(NSNotification*) notification {
	BMLog(@"Registry request failed: %@", [notification object]);
}

-(void) receivedDatasetsForMart:(NSNotification*) notification {
	BMLog(@"Received datasets for mart: %@", notification.object);
}

-(void) failedToReceiveDatasetsForMart:(NSNotification*) notification {
	BMLog(@"Failed to receive datasets for mart %@", notification.object);
}


-(void) receivedConfigurationForDataset:(NSNotification*) notification {
	BMLog(@"Received configuration for dataset");
}

-(void) failedToReceiveConfigurationForDataset:(NSNotification*) notification {
	BMLog(@"Failed to receive configuration for dataset");
}

- (NSString *)windowNibName
{
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"BMQueryDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *) aController
{
    [super windowControllerDidLoadNib:aController];
    // Add any code here that needs to be executed once the windowController has loaded the document's window.
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError
{
	NSLog(@"Data of type '%@'", typeName);
    // Insert code here to write your document to data of the specified type. If the given outError != NULL, ensure that you set *outError when returning nil.

    // You can also choose to override -fileWrapperOfType:error:, -writeToURL:ofType:error:, or -writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.

    // For applications targeted for Panther or earlier systems, you should use the deprecated API -dataRepresentationOfType:. In this case you can also choose to override -fileWrapperRepresentationOfType: or -writeToFile:ofType: instead.

    if ( outError != NULL ) {
		*outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:unimpErr userInfo:NULL];
	}
	return nil;
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError
{
	
	NSLog(@"Read from data of type '%@'", typeName);
	BMQueryXMLParser *parser = [[BMQueryXMLParser alloc] initWithData: data];
	
	BMLog(@"BioMart query XML: %@", parser);
	
    // Insert code here to read your document from the given data of the specified type.  If the given outError != NULL, ensure that you set *outError when returning NO.

    // You can also choose to override -readFromFileWrapper:ofType:error: or -readFromURL:ofType:error: instead. 
    
    // For applications targeted for Panther or earlier systems, you should use the deprecated API -loadDataRepresentation:ofType. In this case you can also choose to override -readFromFile:ofType: or -loadFileWrapperRepresentation:ofType: instead.
    
    if ( parser.error != NULL ) {
		*outError = parser.error;
	}
    return YES;
}

#pragma mark Actions
-(IBAction) runQuery:(id) sender {
	BMLog(@"Run query");
}

-(IBAction) addFilter:(id) sender {
	BMLog(@"Add filter");
}

-(IBAction) addAttribute:(id) sender {
	BMLog(@"Add attribute");
}

#pragma mark Document window title

-(NSString*) displayName {
	return @"Biomartify";
}

/*
- (NSString *) windowTitleForDocumentDisplayName: (NSString *) displayName
{
    NSString *string;
    string = [NSString stringWithFormat: @"Overview of %@", displayName];
	
    return (string);
	
} // windowTitleForDocumentDisplayName
 */

@end