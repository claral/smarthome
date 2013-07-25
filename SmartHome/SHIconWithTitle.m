//
//  SHIconWithTitle.m
//  SmartHome
//
//  Created by Lisa Hüfner on 11.07.13.
//  Copyright (c) 2013 TUM lfe. All rights reserved.
//

#import "SHIconWithTitle.h"

@implementation SHIconWithTitle

@synthesize icon = _icon;

- (UIImage*)icon
{
    CGSize newSize = CGSizeMake(50, 50); //resize icon
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [_icon drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
