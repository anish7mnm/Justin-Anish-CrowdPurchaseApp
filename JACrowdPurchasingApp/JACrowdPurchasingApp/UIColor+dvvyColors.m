//
//  UIColor+dvvyColors.m
//  JACrowdPurchasingApp
//
//  Created by Justin on 4/3/15.
//  Copyright (c) 2015 Anish Kumar. All rights reserved.
//

#import "UIColor+dvvyColors.h"

@implementation UIColor (dvvyColors)

+ (UIColor *)dvvyMainAccent
{
    return [UIColor colorWithRed:0.167 green:0.399 blue:1.000 alpha:1.000];
}

+ (UIColor *)dvvyDarkGrey
{
    return [UIColor colorWithRed:0.225 green:0.221 blue:0.223 alpha:1.000];
}

+ (UIColor *)dvvyBlueAlternative
{
    return [UIColor colorWithRed:0.234 green:0.658 blue:0.743 alpha:1.000];
}

+ (UIColor *)dvvyLightGrey
{
    return [UIColor colorWithRed:0.942 green:0.940 blue:0.940 alpha:1.000];
}

+ (UIColor *)dvvyProgressOrange
{
    return [UIColor colorWithRed:1.000 green:0.642 blue:0.183 alpha:1.000];
}

+ (UIColor *)dvvyProgressYellow
{
    return [UIColor colorWithRed:0.992 green:1.000 blue:0.231 alpha:1.000];
}

+ (UIColor *)dvvyProgressGreen
{
    return [UIColor colorWithRed:0.439 green:1.000 blue:0.609 alpha:1.000];
}

+ (UIColor *)dvvyProgressBlue
{
    return [UIColor dvvyBlueAlternative];
}


@end
