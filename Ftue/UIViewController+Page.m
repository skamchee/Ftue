//
//  UIViewController+Page.m
//  Ftue
//
//  Created by Spencer Kamchee on 3/20/16.
//  Copyright © 2016 spencerkamchee. All rights reserved.
//

#import "UIViewController+Page.h"
#import <objc/runtime.h>



@implementation UIViewController (Page)

@dynamic pageNumber;

- (void)setPageNumber:(NSNumber*)pageNumber{
    objc_setAssociatedObject(self, @selector(pageNumber), pageNumber, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber*)pageNumber{
    return objc_getAssociatedObject(self, @selector(pageNumber));
}

@end
