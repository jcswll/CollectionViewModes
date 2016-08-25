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

@interface CVMCollectionViewController ()

@property (strong, nonatomic, nullable) CVMFullscreenLayout * fullscreenLayout;
@property (strong, nonatomic, nullable) CVMOverviewLayout * overviewLayout;
@property (assign, nonatomic) BOOL inOverview;
@property (strong, nonatomic, nullable) CVMCollectionDataSource * dataSource;

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
    
    UINib * cellNib = [UINib nibWithNibName:@"MarketCell" bundle:nil];
    [[controller collectionView] registerNib:cellNib
                  forCellWithReuseIdentifier:@"Market"];
    
    UINib * footerNib = [UINib nibWithNibName:@"SwitchView"
                                       bundle:nil];
    [[controller collectionView] registerNib:footerNib
                  forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                         withReuseIdentifier:@"Switch"];
    
    [[controller collectionView] setBackgroundColor:[UIColor greenColor]];
    [[controller collectionView] setPagingEnabled:YES];
    
    [controller setDataSource:dataSource];
    [[controller collectionView] setDataSource:dataSource];
    [[controller collectionView] setDelegate:dataSource];
    
    return controller;
}

- (IBAction)toggleLayout
{
    UICollectionViewFlowLayout * newLayout = [self inOverview] ?
                                             [self fullscreenLayout] :
                                             [self overviewLayout];
    BOOL shouldPageAfterToggle = [self inOverview];

    [[self collectionView] setCollectionViewLayout:newLayout
                                              animated:YES];
    [[self collectionView] setPagingEnabled:shouldPageAfterToggle];

    [self setInOverview:![self inOverview]];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [[self fullscreenLayout] invalidateLayout];
    [[self overviewLayout] invalidateLayout];
}

@end
