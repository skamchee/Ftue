//
//  UIView+AutoLayout.m
//  Ftue
//
//  Created by Spencer Kamchee on 5/15/16.
//  Copyright © 2016 spencerkamchee. All rights reserved.
//

#import "UIView+AutoLayout.h"

@implementation UIView (AutoLayout)

- (void)fillParentView:(UIView*)parentView{
    [self fillParentView:parentView top:0 leading:0 bottom:0 trailing:0];
}

- (void)fillParentView:(UIView*)parentView top:(CGFloat)top leading:(CGFloat)leading bottom:(CGFloat)bottom trailing:(CGFloat)trailing
{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    //receiver must be the superview
    //constraintWithItem: a subview of the superview
    //toItem: the superview
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:parentView
                                                           attribute:NSLayoutAttributeTop
                                                          multiplier:1.0
                                                            constant:top]];
    
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                           attribute:NSLayoutAttributeLeading
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:parentView
                                                           attribute:NSLayoutAttributeLeading
                                                          multiplier:1.0
                                                            constant:leading]];
    
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                           attribute:NSLayoutAttributeBottom
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:parentView
                                                           attribute:NSLayoutAttributeBottom
                                                          multiplier:1.0
                                                            constant:bottom]];
    
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                           attribute:NSLayoutAttributeTrailing
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:parentView
                                                           attribute:NSLayoutAttributeTrailing
                                                          multiplier:1.0
                                                            constant:trailing]];
    [self setNeedsLayout];
}

@end
