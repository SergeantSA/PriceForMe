//
//  SearchResultCell.m
//  PriceForMe
//
//  Created by SergeantSA on 4/16/15.
//  Copyright (c) 2015 PriceForMe. All rights reserved.
//

#import "SearchResultCell.h"
#import "ListItem.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "UIImage+Resize.h"

@interface SearchResultCell ()

@property (weak, nonatomic) IBOutlet UIImageView *itemImageView;
@property (weak, nonatomic) IBOutlet UILabel *itemNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *hostNameLabel;

@end

@implementation SearchResultCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureForListItem:(ListItem *)item
{
  self.itemNameLabel.text = item.name;
  self.hostNameLabel.text = item.hostName;
  self.priceNameLabel.text = item.priceName;
//  [self.itemImageView
//      setImageWithURL:[NSURL URLWithString:item.imageURL]
//            placeholderImage:[UIImage imageNamed:@"Placeholder"]];
  NSURL *url = [NSURL URLWithString:item.imageURL];
  NSURLRequest *request = [NSURLRequest requestWithURL:url];
  UIImage *placeholderImage = [[UIImage imageNamed:@"Placeholder"]
                                scaledToSize:CGSizeMake(100, 100)];
  
  __weak SearchResultCell *weakCell = self;
  
  [self.itemImageView setImageWithURLRequest:request placeholderImage:placeholderImage
      success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        weakCell.itemImageView.image =
                        [image scaledToSize:CGSizeMake(100, 100)];
        [weakCell setNeedsLayout];
  } failure:nil];
}

- (void)prepareForReuse
{
  [super prepareForReuse];
  [self.itemImageView cancelImageRequestOperation];
  self.itemNameLabel.text = nil;
  self.hostNameLabel.text = nil;
  self.priceNameLabel.text = nil;
}

@end
