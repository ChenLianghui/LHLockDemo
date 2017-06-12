//
//  NSObject+Swizzle.h
//  BeikeCustomer
//
//  Created by 徐传勇 on 15/7/27.
//  Copyright (c) 2015年 daman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Swizzle)

+ (void)instanceSwizzle:(SEL)origSEL with:(SEL)overrideSEL;
+ (void)classSwizzle:(SEL)origSEL with:(SEL)overrideSEL;

@end
