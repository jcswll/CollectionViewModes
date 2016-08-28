//
//  CVMFullscreenLayout.m
//  CollectionViewModes
//
//  Created by Joshua Caswell on 8/23/16.
//  Copyright © 2016 Josh Caswell. All rights reserved.
//

#import "CVMFullscreenLayout.h"

@implementation CVMFullscreenLayout
{
    NSInteger numItems;
    CGSize layoutSize;
    // The other layout's prepareForLayout will be called during the
    // transition, sometimes _after_ ours. We must manually track which
    // layout is incoming for decisions about paging.
    BOOL transitioningAway;
}

- (id)init
{
    self = [super init];
    if( !self ) return nil;
    
    [self setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    layoutSize = [[UIScreen mainScreen] bounds].size;
    [self setItemSize:layoutSize];
    // "Line" spacing is between _columns_ for horizontal scrolling
    [self setMinimumLineSpacing:0];
    [self setSectionInset:UIEdgeInsetsZero];
    [self setFooterReferenceSize:CGSizeMake(91, 0)];
    [self setSectionFootersPinToVisibleBounds:YES];
    
    return self;
}

- (void)prepareLayout
{
    [super prepareLayout];
    
    numItems = [[self collectionView] numberOfItemsInSection:0];
    
    if( !transitioningAway ){
        [[self collectionView] setPagingEnabled:YES];
    }
}

- (void)prepareForTransitionToLayout:(UICollectionViewLayout *)newLayout
{
    transitioningAway = YES;
}

-(void)prepareForTransitionFromLayout:(UICollectionViewLayout *)oldLayout
{
    transitioningAway = NO;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)_
{
    return CGPointMake([self pageIndex] * layoutSize.width, 0);
}

- (CGSize)collectionViewContentSize
{
    return CGSizeMake(layoutSize.width * numItems, layoutSize.height);
}

- (void)willTransitionToSize:(CGSize)size
{
    [self invalidateLayout];
    layoutSize = size;
    [self setItemSize:layoutSize];
}

- (void)updatePageIndex
{
    CGFloat xOffset = [[self collectionView] contentOffset].x;
    CGFloat width = layoutSize.width;
    
    [self setPageIndex:floor(xOffset / width)];
}

@end
