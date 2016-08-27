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

@interface CVMCollectionViewController () <UICollectionViewDelegate>

@property (strong, nonatomic, nullable) CVMFullscreenLayout * fullscreenLayout;
@property (strong, nonatomic, nullable) CVMOverviewLayout * overviewLayout;
@property (strong, nonatomic, nullable) CVMCollectionDataSource * dataSource;
@property (assign, nonatomic) BOOL inOverview;

@end

@implementation CVMCollectionViewController

+ (id)controllerWithDataSource:(CVMCollectionDataSource *)dataSource
{
    CVMFullscreenLayout * fullscreenLayout = [CVMFullscreenLayout new];
    
    CVMCollectionViewController * controller =
        [[self alloc] initWithCollectionViewLayout:fullscreenLayout];
    
    [controller setInOverview:NO];
    [controller setFullscreenLayout:fullscreenLayout];
    [controller setOverviewLayout:[CVMOverviewLayout new]];
    [controller setDataSource:dataSource];
    
    [dataSource registerViewsWithCollectionView:[controller collectionView]];

    [[controller collectionView] setBackgroundColor:[UIColor greenColor]];
    [[controller collectionView] setDataSource:dataSource];
    [[controller collectionView] setDelegate:controller];
    
    return controller;
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
    
    if( _inOverview ) return;
    
    [[self fullscreenLayout] updatePageIndex];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if( _inOverview ) return;
    
    [[self fullscreenLayout] updatePageIndex];
}

@end
