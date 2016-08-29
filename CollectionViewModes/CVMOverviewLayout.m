//
//  CVMOverviewLayout.m
//  CollectionViewModes
//
//  Created by Joshua Caswell on 8/19/16.
//  Copyright © 2016 Josh Caswell. All rights reserved.
//

#import "CVMOverviewLayout.h"

@interface CVMOverviewLayout ()

@property (assign, nonatomic) CGSize layoutSize;

- (void)updateSizes;

@end

@implementation CVMOverviewLayout
{
    CGSize derivedItemSize;
}

+ (instancetype)layoutWithSize:(CGSize)layoutSize
{
    return [[self alloc] initWithLayoutSize:layoutSize];
}

- (id)initWithLayoutSize:(CGSize)layoutSize
{
    self = [super init];
    if( !self ) return nil;
    
    [self setScrollDirection:UICollectionViewScrollDirectionVertical];
    _layoutSize = layoutSize;
    [self updateSizes];
    
    return self;
}

- (void)setLayoutSize:(CGSize)layoutSize
{
    _layoutSize = layoutSize;
    [self updateSizes];
}

-(void)prepareForTransitionFromLayout:(UICollectionViewLayout *)oldLayout
{
    [super prepareForTransitionFromLayout:oldLayout];
    
    [self setLayoutSize:[[self collectionView] bounds].size];
    
    [[self collectionView] setPagingEnabled:NO];
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

- (void)updateSizes
{
    derivedItemSize = CGSizeMake([self layoutSize].width / 4,
                                 [self layoutSize].height / 4);
    [self setItemSize:derivedItemSize];
    [self setMinimumLineSpacing:derivedItemSize.width / 3];
    [self setMinimumInteritemSpacing:derivedItemSize.width / 3];
    UIEdgeInsets sectionInset = UIEdgeInsetsMake(50, derivedItemSize.width / 3,
                                                 50, derivedItemSize.width / 3);
    [self setSectionInset:sectionInset];
}

@end
