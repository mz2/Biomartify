//
//  BMRegistry.m
//  Biomartify
//
//  Created by Matias Piipari on 07/05/2010.
//  Copyright 2010 Wellcome Trust Sanger Institute. All rights reserved.
//

#import "BMRegistry.h"


@implementation BMRegistry
@synthesize url = _url;
@synthesize marts = _marts;

//=========================================================== 
// - (id)init
//
//=========================================================== 
- (id)init
{
    if (self = [super init]) {
        [self setMarts: [NSMutableArray array]];
    }
    return self;
}


//=========================================================== 
// dealloc
//=========================================================== 
- (void)dealloc
{
    [_marts release], _marts = nil;
    [super dealloc];
}



@end
