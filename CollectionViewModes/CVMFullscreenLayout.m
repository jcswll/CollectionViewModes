//
//  CVMFullscreenLayout.m
//  CollectionViewModes
//
//  Created by Joshua Caswell on 8/23/16.
//  Copyright © 2016 Josh Caswell. All rights reserved.
//

#import "CVMFullscreenLayout.h"

@interface CVMFullscreenLayout ()

@property (assign, nonatomic) CGSize layoutSize;

@end

@implementation CVMFullscreenLayout
{
    NSInteger numItems;
    BOOL didInitialLayout;
}

+ (instancetype)layoutWithSize:(CGSize)layoutSize
{
    return [[self alloc] initWithLayoutSize:layoutSize];
}

- (id)initWithLayoutSize:(CGSize)layoutSize
{
    self = [super init];
    if( !self ) return nil;
    
    [self setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    _layoutSize = layoutSize;
    [self setItemSize:_layoutSize];
    // "Line" spacing is between _columns_ for horizontal scrolling
    [self setMinimumLineSpacing:0];
    [self setSectionInset:UIEdgeInsetsZero];
   
    return self;
}

- (void)setLayoutSize:(CGSize)layoutSize
{
    _layoutSize = layoutSize;
    [self setItemSize:_layoutSize];
}

- (void)prepareLayout
{
    [super prepareLayout];
    
    numItems = [[self collectionView] numberOfItemsInSection:0];
    
    // This is not an appropriate place to set paging during transitions,
    // because both layouts recieve this message in indeterminate order.
    // However, there is no transition on initial presentation.
    if( !didInitialLayout ){
        [[self collectionView] setPagingEnabled:YES];
        didInitialLayout = YES;
    }
}

- (void)prepareForTransitionFromLayout:(UICollectionViewLayout *)oldLayout
{
    [super prepareForTransitionFromLayout:oldLayout];
    
    [self setLayoutSize:[[self collectionView] bounds].size];
    
    [[self collectionView] setPagingEnabled:YES];
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)_
{
    return CGPointMake([self pageIndex] * [self layoutSize].width, 0);
}

- (CGSize)collectionViewContentSize
{
    return CGSizeMake([self layoutSize].width * numItems, 
                      [self layoutSize].height);
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    CGSize newSize = newBounds.size;
    BOOL sizeDidChange = !CGSizeEqualToSize([self layoutSize], newSize);
    if( sizeDidChange ){
        [self setLayoutSize:newSize];
    }
    
    return sizeDidChange;
}

- (void)updatePageIndex
{
    CGFloat xOffset = [[self collectionView] contentOffset].x;
    CGFloat width = [self layoutSize].width;
    
    [self setPageIndex:floor(xOffset / width)];
}

@end
