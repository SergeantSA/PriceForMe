//
//  LandscapeDataCell.h
//  PriceForMe
//
//  Created by SergeantSA on 5/17/15.
//  Copyright (c) 2015 PriceForMe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ListItem;

@interface LandscapeDataCell : UICollectionViewCell

- (void)configureForListItem:(ListItem *)item;

@end
