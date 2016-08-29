//
//  CVMOverviewLayout.m
//  CollectionViewModes
//
//  Created by Joshua Caswell on 8/19/16.
//  Copyright © 2016 Josh Caswell. All rights reserved.
//

#import "CVMOverviewLayout.h"

@interface CVMOverviewLayout ()

- (void)updateSizes;

@end

@implementation CVMOverviewLayout
{
    NSInteger numItems;
    CGSize derivedItemSize;
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
    
    [self setScrollDirection:UICollectionViewScrollDirectionVertical];
    layoutSize = [[UIScreen mainScreen] bounds].size;
    [self updateSizes];
    
    return self;
}

-(void)prepareLayout
{
    if( !transitioningAway ){
        [[self collectionView] setPagingEnabled:NO];
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

- (void)willTransitionToSize:(CGSize)size
{
    [self invalidateLayout];
    layoutSize = size;
    [self updateSizes];
}

- (void)updateSizes
{
    derivedItemSize = CGSizeMake(layoutSize.width / 4,
                                 layoutSize.height / 4);
    [self setItemSize:derivedItemSize];
    [self setMinimumLineSpacing:derivedItemSize.width / 3];
    [self setMinimumInteritemSpacing:derivedItemSize.width / 3];
    UIEdgeInsets sectionInset = UIEdgeInsetsMake(50, derivedItemSize.width / 3,
                                                 50, derivedItemSize.width / 3);
    [self setSectionInset:sectionInset];
}

@end
