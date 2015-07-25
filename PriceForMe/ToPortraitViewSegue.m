//
//  ToPortraitViewSegue.m
//  PriceForMe
//
//  Created by SergeantSA on 5/21/15.
//  Copyright (c) 2015 PriceForMe. All rights reserved.
//

#import "ToPortraitViewSegue.h"

@implementation ToPortraitViewSegue

- (void)perform
{
  UIViewController *sourceViewController =
  self.sourceViewController;
  UIViewController *destinationViewController =
  self.destinationViewController;
  
  [sourceViewController.view.superview
        insertSubview:destinationViewController.view atIndex:0];
  
  [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
    sourceViewController.view.alpha = 0.0f;
  } completion:^(BOOL finished) {
    [destinationViewController.view removeFromSuperview];
    [sourceViewController dismissViewControllerAnimated:NO completion:nil];
  }];
}

@end
