//
//  DetailViewController.h
//  PriceForMe
//
//  Created by SergeantSA on 4/16/15.
//  Copyright (c) 2015 PriceForMe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ListItem;

typedef NS_ENUM(NSUInteger, DetailViewControllerAnimationType) {
  DetailViewControllerAnimationTypeSlide,
  DetailViewControllerAnimationTypeFade
};

@interface DetailViewController : UIViewController

@property (nonatomic, strong) ListItem *item;

- (void)presentInParentViewController:
                          (UIViewController *)parentViewController;
- (void)dismissFromParentViewController:
                  (DetailViewControllerAnimationType)animationType;

@end
