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

- (void)configureForListItem:(ListItem *)item;

@end
