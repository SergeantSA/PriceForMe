//
//  ToLandscapeViewSegue.m
//  PriceForMe
//
//  Created by SergeantSA on 5/21/15.
//  Copyright (c) 2015 PriceForMe. All rights reserved.
//

#import "ToLandscapeViewSegue.h"

@implementation ToLandscapeViewSegue

- (void)perform
{
  UIViewController *sourceViewController =
                                  self.sourceViewController;
  UIViewController *destinationViewController =
                              self.destinationViewController;
  
  [sourceViewController.view
                  addSubview:destinationViewController.view];
  
  destinationViewController.view.alpha = 0.0f;
  [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
    destinationViewController.view.alpha = 1.0f;
  } completion:^(BOOL finished) {
    [destinationViewController.view removeFromSuperview];
    [sourceViewController presentViewController:destinationViewController animated:NO completion:nil];
  }];
}

@end
