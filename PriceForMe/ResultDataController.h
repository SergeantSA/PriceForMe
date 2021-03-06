//
//  ResultDataController.h
//  PriceForMe
//
//  Created by SergeantSA on 3/10/15.
//  Copyright (c) 2015 PriceForMe. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ListItem;

@interface ResultDataController : NSObject

@property(nonatomic, copy, readonly) NSString *textForSearch;

+ (ResultDataController *)sharedSearchResults;
- (void)searchForText:(NSString *)text;
- (NSInteger)resultsCount;
- (ListItem *)resultAtIndex:(NSUInteger)index;

@end
