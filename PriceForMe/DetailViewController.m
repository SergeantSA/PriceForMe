//
//  DetailViewController.m
//  PriceForMe
//
//  Created by SergeantSA on 4/16/15.
//  Copyright (c) 2015 PriceForMe. All rights reserved.
//

#import "DetailViewController.h"
#import "ListItem.h"
#import "GradientView.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface DetailViewController () <UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIView *popupView;
@property (weak, nonatomic) IBOutlet UILabel *itemNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *hostNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *itemImageView;

@end

@implementation DetailViewController
{
  GradientView *_gradientView;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.view.backgroundColor = [UIColor clearColor];
  
  UITapGestureRecognizer *gestureRecognizer =
      [[UITapGestureRecognizer alloc] initWithTarget:self
                                        action:@selector(close:)];
  gestureRecognizer.cancelsTouchesInView = NO;
  gestureRecognizer.delegate = self;
  
  [self.view addGestureRecognizer:gestureRecognizer];
  
  self.popupView.layer.cornerRadius = 10.0f;
  
  if (self.item != nil) {
    [self updateUI];
  }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
  return (touch.view == self.view);
}

- (void)updateUI
{
  self.itemNameLabel.text = self.item.name;
  self.hostNameLabel.text = self.item.hostName;
  self.priceNameLabel.text = self.item.priceName;
  [self.itemImageView setImageWithURL:
                        [NSURL URLWithString:self.item.imageURL]];
}

- (void)dealloc
{
  [self.itemImageView cancelImageRequestOperation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)presentInParentViewController:
                          (UIViewController *)parentViewController
{
  _gradientView = [[GradientView alloc]
                   initWithFrame:parentViewController.view.bounds];
  [parentViewController.view addSubview:_gradientView];
  
//  self.view.frame = parentViewController.view.bounds;
  [parentViewController.view addSubview:self.view];
  [parentViewController addChildViewController:self];
  
  CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation
                       animationWithKeyPath:@"transform.scale"];
  
  bounceAnimation.duration = 0.4;
  bounceAnimation.delegate = self;
  
  bounceAnimation.values = @[ @0.7, @1.2, @0.9, @1.0 ];
  bounceAnimation.keyTimes = @[ @0.0, @0.334, @0.666, @1.0 ];
  
  bounceAnimation.timingFunctions = @[
    [CAMediaTimingFunction
          functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
    [CAMediaTimingFunction
          functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
    [CAMediaTimingFunction
          functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
  
  [self.view.layer addAnimation:bounceAnimation
                         forKey:@"bounceAnimation"];
  
  CABasicAnimation *fadeAnimation = [CABasicAnimation
                                animationWithKeyPath:@"opacity"];
  fadeAnimation.fromValue = @0.0f;
  fadeAnimation.toValue = @1.0f;
  fadeAnimation.duration = 0.2;
  [_gradientView.layer addAnimation:fadeAnimation
                             forKey:@"fadeAnimation"];
}

- (void)dismissFromParentViewController
{
  [self willMoveToParentViewController:nil];
  
  [UIView animateWithDuration:0.3 animations:^{
    CGRect rect = self.view.bounds;
    rect.origin.y += rect.size.height;
    self.view.frame = rect;
    _gradientView.alpha = 0.0f;
    
  } completion:^(BOOL finished) {
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
    
    [_gradientView removeFromSuperview];
  }];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
  [self didMoveToParentViewController:self.parentViewController];
}

- (IBAction)close:(id)sender {
  [self dismissFromParentViewController];
}

- (IBAction)goToSite:(id)sender
{
  [[UIApplication sharedApplication] openURL:
                              [NSURL URLWithString:self.item.url]];
}

@end
