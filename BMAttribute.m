//
//  BMAttribute.m
//  Biomartify
//
//  Created by Matias Piipari on 07/05/2010.
//  Copyright 2010 Wellcome Trust Sanger Institute. All rights reserved.
//

#import "BMAttribute.h"


@implementation BMAttribute
@synthesize name = _name;

+(id) attribute {
	return [[[BMAttribute alloc] init] autorelease];
}

@end
