//
//  CVMOverviewLayout.m
//  CollectionViewModes
//
//  Created by Joshua Caswell on 8/19/16.
//  Copyright © 2016 Josh Caswell. All rights reserved.
//

#import "CVMOverviewLayout.h"

static NSString * const kSwitchViewNibName = @"SwitchView";
static NSString * const kSwitchViewKind = @"SwitchView";

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
    
    UINib * footerNib = [UINib nibWithNibName:kSwitchViewNibName
                                       bundle:nil];
    [self registerNib:footerNib forDecorationViewOfKind:kSwitchViewKind];
    
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
    
    // Without this adjustment, the switch does not float with
    // scrolling; its frame is fixed to the value from the last layout pass
    CGRect switchFrame = [switchAttributes frame];
    CGFloat boundsBottom = CGRectGetMaxY([[self collectionView] bounds]);
    
    if( boundsBottom != CGRectGetMaxY(switchFrame) ){
        switchFrame.origin.y = boundsBottom - switchFrame.size.height;
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
