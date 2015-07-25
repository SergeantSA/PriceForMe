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

+ (ResultDataController *)sharedSearchResults
{
  static ResultDataController *_sharedSearchResults = nil;
  
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _sharedSearchResults = [[self alloc] init];
  });
  
  return _sharedSearchResults;
}

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
  
  _textForSearch = [NSString stringWithString:text];
}

- (void)initializeDefaults
{
  ListItem *item = [[ListItem alloc] init];
  item.name = @"Женские кеды KEDS";
  item.imageURL = @"http://kedy-vans.com.ua/images/.t/_prod/KEDS_women/.w220_1396971450__DSC0375.jpg";
  item.currName = @"UAH";
  item.priceName = @"12 340.00 грн";
  item.url = @"http://kedy-vans.com.ua/c15-zhenskie_kedi_keds";
  item.hostName = @"kedy-vans.com.ua/images/.t/_prod/KEDS_women";
  item.crossPrice = 15.623114600232526f;
  
  [self.searchResults addObject:item];
  
  item = [[ListItem alloc] init];
  item.name = @"Кеды Dual-Dual-Dual-Dual-Dual-Dual-Dual-Dual-Dual-Dual-Dual-Dual-Dual-Dual-Dual";
  item.imageURL = @"http://la-boni.com/images/product/s/3451c67d.png";
  item.currName = @"UAH";
  item.priceName = @"200.00 грн";
  item.url = @"http://la-boni.com/catalog/kedy-dual";
  item.hostName = @"la-boni.com";
  item.crossPrice = 15.623114600232526f;
  
  [self.searchResults addObject:item];
  
  item = [[ListItem alloc] init];
  item.name = @"ТМ Befado Польша - мокасины, кеды и много всякой прочей фигни по бешенным ценам. Намного дороже, чем в Польше!";
  item.imageURL = @"http://pic1.kidstaff.net/pictures_user/13/96346/3022586/96346_20140410120250_250x250.jpg";
  item.currName = @"UAH";
  item.priceName = @"789 456 325.00 грн";
  item.url = @"http://www.kidstaff.com.ua/tema-3022586.html";
  item.hostName = @"kidstaff.com.ua/pictures_user/13/96346/3022586/96346_20140410120250_250x250.jpg";
  item.crossPrice = 15.623114600232526f;
  
  [self.searchResults addObject:item];
  
  item = [[ListItem alloc] init];
  item.name = @"Кеды Keddo";
  item.imageURL = @"http://fankyshop.net/images/.t/_prod/!_New_14.12.11/Men/KEDY/.w150_1373540573__DSC7923(1).jpg";
  item.currName = @"UAH";
  item.priceName = @"590.00 грн";
  item.url = @"http://fankyshop.net/c817-kedi_keddo";
  item.hostName = @"fankyshop.net";
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
