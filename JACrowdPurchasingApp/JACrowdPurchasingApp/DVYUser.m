//
//  DVYUser.m
//  JACrowdPurchasingApp
//
//  Created by Justin on 3/22/15.
//  Copyright (c) 2015 Anish Kumar. All rights reserved.
//

#import "DVYUser.h"

@implementation DVYUser

@dynamic username;
@dynamic fullName;
@dynamic email;
@dynamic profilePicture;

+(NSString *)parseClassName
{
    return @"User";
}

@end
