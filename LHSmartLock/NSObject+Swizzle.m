//
//  NSObject+Swizzle.m
//  BeikeCustomer
//
//  Created by 徐传勇 on 15/7/27.
//  Copyright (c) 2015年 daman. All rights reserved.
//

#import "NSObject+Swizzle.h"

@implementation NSObject (Swizzle)

+ (void)instanceSwizzle:(SEL)origSEL with:(SEL)overrideSEL; {
    Class c = [self class];
    Method origMethod = class_getInstanceMethod(c, origSEL);
    Method overrideMethod= class_getInstanceMethod(c, overrideSEL);
    
    if(class_addMethod(c, origSEL, method_getImplementation(overrideMethod),method_getTypeEncoding(overrideMethod)))
    {
        class_replaceMethod(c,overrideSEL, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    }
    else
    {
        method_exchangeImplementations(origMethod,overrideMethod);
    }
}

+ (void)classSwizzle:(SEL)origSEL with:(SEL)overrideSEL {
    Class c = object_getClass((id)self);
    Method origMethod = class_getClassMethod(c, origSEL);
    Method overrideMethod= class_getClassMethod(c, overrideSEL);
    if(class_addMethod(c, origSEL, method_getImplementation(overrideMethod),method_getTypeEncoding(overrideMethod)))
    {
        class_replaceMethod(c,overrideSEL, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    }
    else
    {
        method_exchangeImplementations(origMethod,overrideMethod);
    }
}

@end
