//
//  CVMCollectionViewController.m
//  CollectionViewModes
//
//  Created by Joshua Caswell on 8/24/16.
//  Copyright © 2016 Josh Caswell. All rights reserved.
//

#import "CVMCollectionViewController.h"
#import "CVMFullscreenLayout.h"
#import "CVMOverviewLayout.h"
#import "CVMCollectionDataSource.h"
#import "CVMRotatableLayout.h"
#import "UIView+WSSSimpleConstraints.h"

@interface CVMCollectionViewController () <UICollectionViewDelegate>

@property (strong, nonatomic, nullable) CVMFullscreenLayout * fullscreenLayout;
@property (strong, nonatomic, nullable) CVMOverviewLayout * overviewLayout;
@property (strong, nonatomic, nullable) CVMCollectionDataSource * dataSource;
@property (strong, nonatomic, nullable) UICollectionView * collectionView;
@property (assign, nonatomic) BOOL inOverview;

@end

@implementation CVMCollectionViewController

+ (id)controllerWithDataSource:(CVMCollectionDataSource *)dataSource
                         frame:(CGRect)frame
{
    CVMFullscreenLayout * fullscreenLayout = [CVMFullscreenLayout new];
    
    UICollectionView * collectionView =
        [[UICollectionView alloc] initWithFrame:frame
                           collectionViewLayout:fullscreenLayout];
    
    CVMCollectionViewController * controller = [self new];
    
    [controller setCollectionView:collectionView];
    [controller setInOverview:NO];
    [controller setFullscreenLayout:fullscreenLayout];
    [controller setOverviewLayout:[CVMOverviewLayout new]];
    [controller setDataSource:dataSource];
    
    [dataSource registerViewsWithCollectionView:collectionView];

    [collectionView setBackgroundColor:[UIColor greenColor]];
    [collectionView setDataSource:dataSource];
    [collectionView setDelegate:controller];
    
    return controller;
}

- (instancetype)init
{
    return [super initWithNibName:nil bundle:nil];
}

- (void)setCollectionView:(UICollectionView *)collectionView
{
    _collectionView = collectionView;
    
    [[self view] addSubview:collectionView];
    [[self view] sendSubviewToBack:collectionView];
    
    [collectionView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [collectionView WSSCenterInSuperviewInDirections:WSSConstraintDirectionAll];
    [collectionView WSSFitToSuperviewInDirections:WSSConstraintDirectionAll];    
}

- (IBAction)toggleLayout
{
    UICollectionViewFlowLayout * newLayout = [self inOverview] ?
                                             [self fullscreenLayout] :
                                             [self overviewLayout];

    [[self collectionView] setCollectionViewLayout:newLayout
                                              animated:YES];

    [self setInOverview:![self inOverview]];
}

- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id)coordinator
{
    [super viewWillTransitionToSize:size
          withTransitionCoordinator:coordinator];
    
    [[self overviewLayout] willTransitionToSize:size];
    [[self fullscreenLayout] willTransitionToSize:size];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                  willDecelerate:(BOOL)willDecelerate
{
    // Wait until scrolling has settled to calculate page
    if( willDecelerate ) return;
    
    if( [self inOverview]  ) return;
    
    [[self fullscreenLayout] updatePageIndex];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if( [self inOverview]  ) return;
    
    [[self fullscreenLayout] updatePageIndex];
}

- (void)collectionView:(UICollectionView *)collectionView
        didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if( ![self inOverview] ) return;
    
    [[self fullscreenLayout] setPageIndex:[indexPath row]];
    [self toggleLayout];
}

@end
