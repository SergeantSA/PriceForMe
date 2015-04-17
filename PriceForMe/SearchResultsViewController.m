//
//  SearchResultsViewController.m
//  PriceForMe
//
//  Created by SergeantSA on 3/10/15.
//  Copyright (c) 2015 PriceForMe. All rights reserved.
//

#import "SearchResultsViewController.h"
#import "ResultDataController.h"
#import "SearchResultCell.h"
#import "DetailViewController.h"

@interface SearchResultsViewController () <UITableViewDataSource,
                          UITableViewDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *itemNameLabel;

@end

@implementation SearchResultsViewController {
  ResultDataController *_data;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
  if ((self = [super initWithCoder:aDecoder])) {
    _data = [[ResultDataController alloc] init];
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  [self.searchBar becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView
                  didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [self.searchBar resignFirstResponder];
  
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
  DetailViewController *controller = [self.storyboard
      instantiateViewControllerWithIdentifier:
                                      @"DetailViewController"];
  
  ListItem *item = [_data resultAtIndex:indexPath.row];
  controller.item = item;
  
  [controller presentInParentViewController:self];
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  if ([_data resultsCount] == 0) {
    return nil;
  } else {
    return indexPath;
  }
}

#pragma mark - TableView DataSource

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
  NSInteger itemCount = [_data resultsCount];
  
  if (itemCount == -1) {
    return 0;
  } else if (itemCount == 0) {
    return 1;
  } else {
    return itemCount;
  }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  if ([_data resultsCount] == 0) {
    return [tableView dequeueReusableCellWithIdentifier:@"NothingFoundCell"];
  } else {
    SearchResultCell *cell = (SearchResultCell *)[tableView dequeueReusableCellWithIdentifier:@"SearchResultCell"];
    
    [cell configureForListItem:
                            [_data resultAtIndex:indexPath.row]];
    return cell;
  }
}

#pragma mark - SearchBar Delegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
  [self.searchBar resignFirstResponder];
  
  [_data searchForText:searchBar.text];
  
  [self.tableView reloadData];
}

- (UIBarPosition)positionForBar:(id<UIBarPositioning>)bar
{
  return UIBarPositionTopAttached;
}

@end
