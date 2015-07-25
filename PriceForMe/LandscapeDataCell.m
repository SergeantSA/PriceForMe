//
//  LandscapeDataCell.m
//  PriceForMe
//
//  Created by SergeantSA on 5/17/15.
//  Copyright (c) 2015 PriceForMe. All rights reserved.
//

#import "LandscapeDataCell.h"
#import "ListItem.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "UIImage+Resize.h"

@interface LandscapeDataCell ()

@property (weak, nonatomic) IBOutlet UIImageView *itemImageView;
@property (weak, nonatomic) IBOutlet UILabel *itemNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceNameLabel;

@end

@implementation LandscapeDataCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)configureForListItem:(ListItem *)item
{
  self.itemNameLabel.text = item.name;
  self.priceNameLabel.text =
              [NSString stringWithFormat:@" %@", item.priceName];
//  [self.priceNameLabel sizeToFit];
//  if (self.priceNameLabel.bounds.size.width > 100) {
    self.priceNameLabel.backgroundColor =
                          [UIColor colorWithWhite:1.0 alpha:0.5];
//  }
//  [self.itemNameLabel sizeToFit];
  self.itemNameLabel.backgroundColor =
                          [UIColor colorWithWhite:1.0 alpha:0.65];
  
  CALayer *layer = self.layer;
  layer.borderWidth = 1.0f;
  layer.borderColor = [[UIColor grayColor] CGColor];
  layer.cornerRadius = 8.0f;
  
//  layer.shadowColor = [[UIColor grayColor] CGColor];
//  layer.shadowOffset = CGSizeMake(5.0f, 5.0f);
//  layer.shadowOpacity = 0.1f;
//  layer.shadowRadius = 5.0f;
//  
//  layer.shadowPath =
//          [[UIBezierPath bezierPathWithRect:layer.bounds] CGPath];
  
  //  [self.itemImageView
  //      setImageWithURL:[NSURL URLWithString:item.imageURL]
  //            placeholderImage:[UIImage imageNamed:@"Placeholder"]];
  CGSize itemImageViewSize = self.itemImageView.bounds.size;
  NSURL *url = [NSURL URLWithString:item.imageURL];
  NSURLRequest *request = [NSURLRequest requestWithURL:url];
  UIImage *placeholderImage = [[UIImage imageNamed:@"Placeholder"]
                               scaledToSize:itemImageViewSize];
  
  __weak LandscapeDataCell *weakItemView = self;
  
  [self.itemImageView setImageWithURLRequest:request placeholderImage:placeholderImage
      success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
              weakItemView.itemImageView.image =
                    [image scaledToSize:itemImageViewSize];
//              [weakCell setNeedsLayout];
                                     } failure:nil];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)prepareForReuse
{
  [super prepareForReuse];
  [self.itemImageView cancelImageRequestOperation];
  self.itemNameLabel.text = nil;
  self.priceNameLabel.text = nil;
  
}

@end
