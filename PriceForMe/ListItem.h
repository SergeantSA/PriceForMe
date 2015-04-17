//
//  ListItem.h
//  PriceForMe
//
//  Created by SergeantSA on 3/10/15.
//  Copyright (c) 2015 PriceForMe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListItem : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *imageURL;
@property (nonatomic, copy) NSString *currName;
@property (nonatomic, copy) NSString *priceName;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *hostName;
@property (nonatomic, assign) float  crossPrice;

@end
