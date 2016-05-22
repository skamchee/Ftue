//
//  UIView+AutoLayout.h
//  Ftue
//
//  Created by Spencer Kamchee on 5/15/16.
//  Copyright © 2016 spencerkamchee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AutoLayout)

- (void)fillParentView:(UIView*)parentView;
- (void)fillParentView:(UIView*)parentView top:(CGFloat)top leading:(CGFloat)leading bottom:(CGFloat)bottom trailing:(CGFloat)trailing;

@end
