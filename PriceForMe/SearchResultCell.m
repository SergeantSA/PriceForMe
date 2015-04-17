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
  [self.itemImageView
      setImageWithURL:[NSURL URLWithString:item.imageURL]
            placeholderImage:[UIImage imageNamed:@"Placeholder"]];
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
