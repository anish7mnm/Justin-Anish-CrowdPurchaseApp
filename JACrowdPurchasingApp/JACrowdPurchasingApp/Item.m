//
//  Item.m
//  JACrowdPurchasingApp
//
//  Created by Anish Kumar on 3/27/15.
//  Copyright (c) 2015 Anish Kumar. All rights reserved.
//

#import "Item.h"

@implementation Item


@dynamic itemImage;
@dynamic name;
@dynamic description;



+(NSString *)parseClassName
{
    return @"Item";
}


@end
