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
#import "LandscapeViewController.h"
#import "ToPortraitViewSegue.h"

@interface SearchResultsViewController () <UITableViewDataSource,
                          UITableViewDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SearchResultsViewController {
  ResultDataController *_data;
  DetailViewController *_detailViewController;
  LandscapeViewController *_landscapeViewController;
  
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
  if ((self = [super initWithCoder:aDecoder])) {
    _data = [ResultDataController sharedSearchResults];
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
  [[NSNotificationCenter defaultCenter] addObserver:self
              selector:@selector(onDeviceOrientationDidChange:)
              name:UIDeviceOrientationDidChangeNotification
                                             object:nil];
  
  [self.searchBar becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
//{
//  [super willRotateToInterfaceOrientation:toInterfaceOrientation
//                                 duration:duration];
//  
//  if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {
//    [self hideLandscapeViewWithDuration:duration];
//  } else {
//    [self showLandscapeViewWithDuration:duration];
//  }
//}

//- (void)showLandscapeViewWithDuration:(NSTimeInterval)duration
//{
//  if (_landscapeViewController == nil) {
//    _landscapeViewController = [self.storyboard
//              instantiateViewControllerWithIdentifier:
//                                      @"LandscapeViewController"];
//    _landscapeViewController.view.frame = self.view.bounds;
//    [self.view addSubview:_landscapeViewController.view];
//    [self addChildViewController:_landscapeViewController];
//    [_landscapeViewController
//                              didMoveToParentViewController:self];
//  }
//}

//- (void)hideLandscapeViewWithDuration:(NSTimeInterval)duration
//{
//  if (_landscapeViewController != nil) {
//    [_landscapeViewController willMoveToParentViewController:nil];
//    [_landscapeViewController.view removeFromSuperview];
//    [_landscapeViewController removeFromParentViewController];
//    _landscapeViewController = nil;
//  }
//}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
  [self.searchBar resignFirstResponder];
  [_detailViewController dismissFromParentViewController:
                            DetailViewControllerAnimationTypeFade];
  if ([segue.identifier isEqualToString:@"ToLandscapeViewSegue"]) {
    _landscapeViewController = segue.destinationViewController;
    _landscapeViewController.view.frame = self.view.bounds;
    _landscapeViewController.data = _data;
  }
}

- (IBAction)unwindToPortraitView:(UIStoryboardSegue *)sender
{
  NSLog(@"unwindToPortraitView");
}

- (UIStoryboardSegue *)segueForUnwindingToViewController:(UIViewController *)toViewController fromViewController:(UIViewController *)fromViewController identifier:(NSString *)identifier
{
  ToPortraitViewSegue *segue = [[ToPortraitViewSegue alloc]
                              initWithIdentifier:identifier source:fromViewController destination:toViewController];
  return segue;
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
  _detailViewController = controller;
  
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
  [searchBar resignFirstResponder];
  
  [_data searchForText:searchBar.text];
  
  [self.tableView reloadData];
}

- (UIBarPosition)positionForBar:(id<UIBarPositioning>)bar
{
  return UIBarPositionTopAttached;
}

#pragma mark - Rotation

- (void)onDeviceOrientationDidChange:(NSNotification *)notification
{
  [self performSelector:@selector(updateLandscapeView)
             withObject:nil afterDelay:0];
}

- (void)updateLandscapeView
{
  UIDeviceOrientation deviceOrientation =
                              [UIDevice currentDevice].orientation;
  
  if (UIDeviceOrientationIsLandscape(deviceOrientation)
                            && self.presentedViewController == nil)
  {
    [self performSegueWithIdentifier:
               @"ToLandscapeViewSegue" sender:self];
  }
  else if (deviceOrientation == UIDeviceOrientationPortrait
                            && self.presentedViewController != nil)
  {
    [self dismissViewControllerAnimated:YES completion:NULL];
//    [self performSegueWithIdentifier:
//                @"ToPortraitViewSegue" sender:self];

    if (self.searchBar.text != _data.textForSearch) {
      self.searchBar.text = _data.textForSearch;
      [self.tableView reloadData];
    }
    if ([_data resultsCount] == -1) {
      [self.searchBar becomeFirstResponder];
    }
  }
}

- (NSUInteger)supportedInterfaceOrientations
{
  return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - Cleanup

- (void)dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:self];
  
  [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
}

@end
