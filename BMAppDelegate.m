//
//  BMAppDelegate.m
//  biomartify
//
//  Created by Matias Piipari on 07/05/2010.
//  Copyright 2010 Wellcome Trust Sanger Institute. All rights reserved.
//

#import "BMAppDelegate.h"


@implementation BMAppDelegate

+ (void) initialize {
    NSMutableDictionary *defaultValues = [NSMutableDictionary dictionary];
    [defaultValues setObject: BMServiceBaseURLDefault 
					  forKey: BMServiceBaseURLKey];    
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultValues];
}

- (void) awakeFromNib {

}
- (void)applicationWillFinishLaunching:(NSNotification *)aNotification {

}

@end
