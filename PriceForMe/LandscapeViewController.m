//
//  LandscapeViewController.m
//  PriceForMe
//
//  Created by SergeantSA on 4/22/15.
//  Copyright (c) 2015 PriceForMe. All rights reserved.
//

#import "LandscapeViewController.h"
#import "ResultDataController.h"
#import "LandscapeDataCell.h"
#import "DetailViewController.h"
#import "ToPortraitViewSegue.h"

const CGFloat itemWidth = 240;
const CGFloat itemHeigth = 220;
static CGFloat itemsPerPage = 2;

@interface LandscapeViewController () <UISearchBarDelegate,
            UICollectionViewDataSource, UICollectionViewDelegate,
                                            UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet
                                UICollectionView *collectionView;

@end

@implementation LandscapeViewController
{
//  BOOL _firstTime;
//  DetailViewController *_detailViewController;
  UILabel *_NothingFoundLabel;
}

//- (id)initWithCoder:(NSCoder *)aDecoder
//{
//  if ((self = [super initWithCoder:aDecoder])) {
//      _firstTime = YES;
//  }
//  return self;
//}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.pageControl.numberOfPages = 0;
}

//- (void)viewWillLayoutSubviews
//{
//  [super viewWillLayoutSubviews];
//
//  if (_firstTime) {
//    _firstTime = NO;
////    [self tileItems];
//  }
//}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  if (self.isBeingPresented) {
    self.searchBar.text = _data.textForSearch;
    if ([_data resultsCount] == -1) {
      [self.searchBar becomeFirstResponder];
    } else if ([_data resultsCount] == 0) {
      [self showNothingFoundLabel];
    }
  }
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  
  if (self.isBeingPresented) {
    itemsPerPage = floorf(self.collectionView.frame.size.width / itemWidth);
    if ([_data resultsCount] != -1) {
      self.pageControl.numberOfPages = ceilf([_data resultsCount] / itemsPerPage);
    }
  }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)tileItems
//{
//  const CGFloat buttonWidth = 220;
//  const CGFloat buttonHeigth = 200;
//  const CGFloat marginHorz = (itemWidth - buttonWidth)/2.0f;
//  const CGFloat marginVert = (itemHeigth - buttonHeigth)/2.0f;
//  CGFloat x = 0.0f;
////  CGFloat scrollViewWidth = self.view.bounds.size.width;
////  CGFloat extraSpace = scrollViewWidth -
////                                      itemsPerPage * itemWidth;
//  
//  int resultsCount = [self.data resultsCount];
//  self.scrollView.contentSize = CGSizeMake(
////                            numPages*scrollViewWidth,
//                            resultsCount*itemWidth,
//                            self.scrollView.bounds.size.height);
//  
//  for (int i = 0; i < resultsCount; ++i) {
////    UIButton *button = [UIButton
////                             buttonWithType:UIButtonTypeSystem];
////    button.backgroundColor = [UIColor grayColor];
////    [button setTitle:[NSString stringWithFormat:@"Button_%i", i]
////            forState:UIControlStateNormal];
////    button.frame = CGRectMake(x + marginHorz, 75.0f + marginVert,
////                              buttonWidth, buttonHeigth);
////    [self.scrollView addSubview:button];
//    LandscapeDataCell *view = [[[NSBundle mainBundle] loadNibNamed:@"LandscapeDataCell" owner:self options:nil] objectAtIndex:0];
//    view.frame = CGRectMake(x + marginHorz, 75.0f + marginVert,
//                              buttonWidth, buttonHeigth);
//    view.backgroundColor = [UIColor grayColor];
////    view.itemNameLabel.text =
////                      [NSString stringWithFormat:@"Button_%i", i];
//    [view configureForListItem:[_data resultAtIndex:i]];
//    [self.scrollView addSubview:view];
//    
//    x += itemWidth; // + extraSpace / 3;
//  }
//  
//  int numPages = ceilf(resultsCount/(float)itemsPerPage);
//  self.pageControl.numberOfPages = numPages;
//  self.pageControl.currentPage = 0;
//}

- (IBAction)pageChanged:(UIPageControl *)pageControl
{
//  [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//    self.scrollView.contentOffset = CGPointMake(
////      self.scrollView.bounds.size.width * sender.currentPage, 0);
//                itemsPerPage * itemWidth * sender.currentPage, 0);
//  } completion:nil];
  CGFloat pageWidth = itemsPerPage * itemWidth;
                          //self.collectionView.frame.size.width;
  CGPoint scrollTo = CGPointMake(pageWidth * pageControl.currentPage, 0);
  if (scrollTo.x + self.collectionView.frame.size.width >
      self.collectionView.contentSize.width) {
    scrollTo = CGPointMake(
                    self.collectionView.contentSize.width -
                          self.collectionView.frame.size.width, 0);
  }
  [self.collectionView setContentOffset:scrollTo animated:YES];
}

- (void)showNothingFoundLabel
{
  if (_NothingFoundLabel == nil) {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    _NothingFoundLabel = label;
    label.text = NSLocalizedString(@"No Results Were Found", @"LandscapeView: NothingFoundLabel");
    label.textColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.backgroundColor = [UIColor clearColor];
    [label setFont:[UIFont systemFontOfSize:17.0]];
    
    [label sizeToFit];
    CGRect rect = label.frame;
    rect.size.width = ceilf(rect.size.width/2.0f) * 2.0f;
    rect.size.height = ceilf(rect.size.height/2.0f) * 2.0f;
    label.frame = rect;
    label.center = CGPointMake(
                      CGRectGetMidX(self.view.bounds),
                      CGRectGetMidY(self.view.bounds));
  }
  
  [self.view addSubview:_NothingFoundLabel];
}

//- (UIStoryboardSegue *)segueForUnwindingToViewController:(UIViewController *)toViewController fromViewController:(UIViewController *)fromViewController identifier:(NSString *)identifier
//{
//  ToPortraitViewSegue *segue = [[ToPortraitViewSegue alloc]
//                                initWithIdentifier:identifier source:fromViewController destination:toViewController];
//  return segue;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - SearchBar Delegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
  [self.searchBar resignFirstResponder];
  
  [_data searchForText:searchBar.text];
  
  if ([_data resultsCount] == 0) {
    [self showNothingFoundLabel];
  } else {
    [_NothingFoundLabel removeFromSuperview];
  }
  
  self.pageControl.numberOfPages = ceilf([_data resultsCount] / (float)itemsPerPage);
  
  [self.collectionView reloadData];
}

- (UIBarPosition)positionForBar:(id<UIBarPositioning>)bar
{
  return UIBarPositionTopAttached;
}

#pragma mark - Rotation

- (NSUInteger)supportedInterfaceOrientations
{
  return UIInterfaceOrientationMaskLandscape;
}

#pragma mark - Collection View DataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return [_data resultsCount];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  LandscapeDataCell *cell = (LandscapeDataCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"LandscapeDataCell" forIndexPath:indexPath];
  [cell configureForListItem:[_data resultAtIndex:indexPath.row]];
  return cell;
}

#pragma mark - Collection View Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
  [self.searchBar resignFirstResponder];
  
  [self.collectionView
                deselectItemAtIndexPath:indexPath animated:YES];
  
  DetailViewController *controller = [self.storyboard
                  instantiateViewControllerWithIdentifier:
                                      @"DetailViewController"];
//  _detailViewController = controller;
  
  ListItem *item = [_data resultAtIndex:indexPath.row];
  controller.item = item;
  
  [controller presentInParentViewController:self];
}

#pragma mark - Scroll View Delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
  CGFloat pageWidth = itemsPerPage * itemWidth;
                            //self.collectionView.frame.size.width;
  if (self.collectionView.contentOffset.x ==
          (self.collectionView.contentSize.width -
                self.collectionView.frame.size.width) ) {
    self.pageControl.currentPage =
                                self.pageControl.numberOfPages - 1;
  } else {
    self.pageControl.currentPage =
                  self.collectionView.contentOffset.x / pageWidth;
  }
}

@end
