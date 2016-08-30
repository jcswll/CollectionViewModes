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
#import "UIView+WSSSimpleConstraints.h"

@interface CVMCollectionViewController () <UICollectionViewDelegate>

@property (strong, nonatomic, nullable) UILongPressGestureRecognizer * itemMovementRecognizer;
@property (strong, nonatomic, nullable) CVMFullscreenLayout * fullscreenLayout;
@property (strong, nonatomic, nullable) CVMOverviewLayout * overviewLayout;
@property (strong, nonatomic, nullable) CVMCollectionDataSource * dataSource;
@property (strong, nonatomic, nullable) UICollectionView * collectionView;
@property (assign, nonatomic) BOOL inOverview;

- (IBAction)toggleLayout;
- (void)itemMovementStateChanged:(UILongPressGestureRecognizer *)recognizer;

@end

@implementation CVMCollectionViewController

+ (id)controllerUsingFrame:(CGRect)frame
{
    CVMFullscreenLayout * fullscreenLayout =
        [CVMFullscreenLayout layoutWithSize:frame.size];
    CVMOverviewLayout * overviewLayout =
        [CVMOverviewLayout layoutWithSize:frame.size];
    
    UICollectionView * collectionView =
        [[UICollectionView alloc] initWithFrame:frame
                           collectionViewLayout:fullscreenLayout];
    
    CVMCollectionDataSource * dataSource =
        [CVMCollectionDataSource dataSourceForView:collectionView];
    
    CVMCollectionViewController * controller = [self new];
    
    [controller setCollectionView:collectionView];
    [[controller itemMovementRecognizer] setEnabled:NO];
    [controller setInOverview:NO];
    [controller setFullscreenLayout:fullscreenLayout];
    [controller setOverviewLayout:overviewLayout];
    [controller setDataSource:dataSource];

    [collectionView setBackgroundColor:[UIColor greenColor]];
    [collectionView setDataSource:dataSource];
    [collectionView setDelegate:controller];
    
    return controller;
}

- (void)setCollectionView:(UICollectionView *)collectionView
{
    _collectionView = collectionView;
    
    [[self view] addSubview:collectionView];
    [[self view] sendSubviewToBack:collectionView];
    
    [collectionView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [collectionView WSSCenterInSuperviewInDirections:WSSConstraintDirectionAll];
    [collectionView WSSFitToSuperviewInDirections:WSSConstraintDirectionAll];
    
    [collectionView addGestureRecognizer:[self itemMovementRecognizer]];
}

- (IBAction)toggleLayout
{
    UICollectionViewFlowLayout * newLayout = [self inOverview] ?
                                             [self fullscreenLayout] :
                                             [self overviewLayout];
    
    [self setInOverview:![self inOverview]];
    
    [[self collectionView] setCollectionViewLayout:newLayout
                                              animated:YES];
    [[self itemMovementRecognizer] setEnabled:[self inOverview]];
}

- (UILongPressGestureRecognizer *)itemMovementRecognizer
{
    if( !_itemMovementRecognizer ){
        
        _itemMovementRecognizer =
            [[UILongPressGestureRecognizer alloc]
                initWithTarget:self
                        action:@selector(itemMovementStateChanged:)];
        [_itemMovementRecognizer setMinimumPressDuration:0.3];
    }
    
    return _itemMovementRecognizer;
}

- (void)itemMovementStateChanged:(UILongPressGestureRecognizer *)recognizer
{
    UIGestureRecognizerState state = [recognizer state];
    if( state == UIGestureRecognizerStateBegan ){
        
        CGPoint pressPoint = [recognizer locationInView:[self collectionView]];
        NSIndexPath * pressPath =
            [[self collectionView] indexPathForItemAtPoint:pressPoint];

        if( !pressPath ) return;
        
        [[self collectionView]
            beginInteractiveMovementForItemAtIndexPath:pressPath];
        // Force immediate application of special layout attributes
        [UIView animateWithDuration:0.125 animations:^{
            [[self collectionView] 
                updateInteractiveMovementTargetPosition:pressPoint];
        }];
    }
    else if( state == UIGestureRecognizerStateChanged ){
        
        CGPoint movePoint = [recognizer locationInView:[self collectionView]];
        [[self collectionView] updateInteractiveMovementTargetPosition:movePoint];
    }
    else if( state == UIGestureRecognizerStateEnded ){
        
        [[self collectionView] endInteractiveMovement];
    }
    else if( state == UIGestureRecognizerStateCancelled ){
        
        [[self collectionView] cancelInteractiveMovement];
    }
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
