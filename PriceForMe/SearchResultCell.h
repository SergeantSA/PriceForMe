//
//  SearchResultCell.h
//  PriceForMe
//
//  Created by SergeantSA on 4/16/15.
//  Copyright (c) 2015 PriceForMe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ListItem;

@interface SearchResultCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *itemImageView;
@property (weak, nonatomic) IBOutlet UILabel *itemNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *hostNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceNameLabel;

- (void)configureForListItem:(ListItem *)item;

@end
