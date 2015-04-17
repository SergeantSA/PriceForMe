//
//  ResultDataController.m
//  PriceForMe
//
//  Created by SergeantSA on 3/10/15.
//  Copyright (c) 2015 PriceForMe. All rights reserved.
//

#import "ResultDataController.h"
#import "ListItem.h"

@interface ResultDataController ()

@property (nonatomic, readonly) NSMutableArray *searchResults;

@end

@implementation ResultDataController

- (id)init
{
  if ((self = [super init])) {
  }
  return self;
}

- (void)searchForText:(NSString *)text
{
  if (self.searchResults == nil) {
    _searchResults = [NSMutableArray arrayWithCapacity:10];
  }
  
  [self.searchResults removeAllObjects];
  
  if ([text isEqualToString:@"кеды"]) {
    [self initializeDefaults];
  }
}

- (void)initializeDefaults
{
  ListItem *item = [[ListItem alloc] init];
  item.name = @"Женские кеды KEDS";
  item.imageURL = @"http://kedy-vans.com.ua/images/.t/_prod/KEDS_women/.w220_1396971450__DSC0375.jpg";
  item.currName = @"UAH";
  item.priceName = @"340.00 грн";
  item.url = @"http://kedy-vans.com.ua/c15-zhenskie_kedi_keds";
  item.hostName = @"kedy-vans.com.ua";
  item.crossPrice = 15.623114600232526f;
  
  [self.searchResults addObject:item];
}

- (NSInteger)resultsCount
{
  if (self.searchResults == nil) {
    return -1;
  }
  return [self.searchResults count];
}

- (ListItem *)resultAtIndex:(NSUInteger)index
{
  return self.searchResults[index];
}

@end
