//
//  CVMFullscreenLayout.m
//  CollectionViewModes
//
//  Created by Joshua Caswell on 8/23/16.
//  Copyright © 2016 Josh Caswell. All rights reserved.
//

#import "CVMFullscreenLayout.h"

static NSString * const kSwitchViewNibName = @"SwitchView";
static NSString * const kSwitchViewKind = @"SwitchView";

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
    
    UINib * footerNib = [UINib nibWithNibName:kSwitchViewNibName
                                       bundle:nil];
    [self registerNib:footerNib forDecorationViewOfKind:kSwitchViewKind];
   
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

-(NSArray<UICollectionViewLayoutAttributes *> *)
  layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray * attributes = [super layoutAttributesForElementsInRect:rect];
    
    if( !CGRectIntersectsRect(rect, [self rectForSwitchView]) ) {
        
        return attributes;
    }
    
    static NSIndexPath * kIndexPathZero = nil;
    if( !kIndexPathZero ) {
        kIndexPathZero = [NSIndexPath indexPathForRow:0 inSection:0];
    }
    
    UICollectionViewLayoutAttributes * switchAttributes =
        [self layoutAttributesForDecorationViewOfKind:kSwitchViewKind
                                          atIndexPath:kIndexPathZero];
    
    CGRect switchFrame = [switchAttributes frame];
    CGRect bounds = [[self collectionView] bounds];
    
    if( bounds.origin.x != switchFrame.origin.x ){
        switchFrame.origin.x = bounds.origin.x;
        [switchAttributes setFrame:switchFrame];
    }
    
    return [attributes arrayByAddingObject:switchAttributes];
}

- (UICollectionViewLayoutAttributes *)
    layoutAttributesForDecorationViewOfKind:(NSString *)elementKind
                                atIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewLayoutAttributes * attributes;
    attributes =
        [UICollectionViewLayoutAttributes
            layoutAttributesForDecorationViewOfKind:elementKind
                                      withIndexPath:indexPath];
    [attributes setFrame:[self rectForSwitchView]];
    [attributes setZIndex:NSIntegerMax];
    
    return attributes;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (CGRect)rectForSwitchView
{
    CGRect bounds = [[self collectionView] bounds];
    return CGRectMake(bounds.origin.x, bounds.size.height - 74, 91, 74);
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
