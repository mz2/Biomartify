//
//  BMFilter.m
//  Biomartify
//
//  Created by Matias Piipari on 07/05/2010.
//  Copyright 2010 Wellcome Trust Sanger Institute. All rights reserved.
//

#import "BMFilter.h"


@implementation BMFilter
@synthesize name = _name;

+(id) filter {
	return [[[[BMFilter class] alloc] init] autorelease];
}

@end
