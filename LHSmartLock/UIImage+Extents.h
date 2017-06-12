//
//  UIImage+Extents.h
//  CiCi
//
//  Created by 胡立 on 13-10-10.
//  Copyright (c) 2013年 Paitao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extents)

- (NSString*)md5;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

+ (UIImage *)imageFromColors:(NSArray*)colors size:(CGSize)size;

- (UIImage *)imageWithColor:(UIColor *)color;

- (UIImage *)imageWithTintColor:(UIColor *)tintColor;

- (UIImage *)imageWithGradientTintColor:(UIColor *)tintColor;

- (UIImage *)scaleToSize:(CGSize)size;

- (UIImage *)scaleToMaximumSize:(CGSize)size;

- (UIImage *)scaleToMinimumSize:(CGSize)size;

- (UIImage *)roundImageWithCornerRadius:(CGFloat)cornerRadius;

- (UIImage *)resizedImage:(CGSize)newSize interpolationQuality:(CGInterpolationQuality)quality;

@end
