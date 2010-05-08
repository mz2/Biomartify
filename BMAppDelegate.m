//
//  BMAppDelegate.m
//  biomartify
//
//  Created by Matias Piipari on 07/05/2010.
//  Copyright 2010 Wellcome Trust Sanger Institute. All rights reserved.
//

#import "BMAppDelegate.h"
#import "BMartService.h"


@implementation BMAppDelegate

- (void) awakeFromNib {
	BMLog(@"BMAppDelegate: awakening from NIB");
	[[BMartService sharedMartService] requestRegistryForMartServiceAtURL: [BMartService martRegistryURL]];
}

- (void)applicationWillFinishLaunching:(NSNotification *)aNotification {
	BMLog(@"Application will finish launching");
	
}

@end
