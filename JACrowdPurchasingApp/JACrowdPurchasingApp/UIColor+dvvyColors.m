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
    return [UIColor colorWithRed:0.322 green:0.759 blue:0.783 alpha:1.000];
}

+ (UIColor *)dvvyDarkGrey
{
    return [UIColor colorWithRed:0.225 green:0.221 blue:0.223 alpha:1.000];
}

+ (UIColor *)dvvyBlueAlternative
{
    return [UIColor colorWithRed:0.210 green:0.699 blue:0.748 alpha:1.000];
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
    return [UIColor colorWithRed:0.353 green:0.757 blue:0.530 alpha:1.000];
}

+ (UIColor *)dvvyProgressBlue
{
    return [UIColor dvvyBlueAlternative];
}


@end
