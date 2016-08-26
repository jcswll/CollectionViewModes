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
}

- (id)init
{
    self = [super init];
    if( !self ) return nil;
    
    [self setScrollDirection:UICollectionViewScrollDirectionVertical];
    layoutSize = [[UIScreen mainScreen] bounds].size;
    [self updateSizes];
    
    [self setFooterReferenceSize:CGSizeMake(0, 100)];
    [self setSectionFootersPinToVisibleBounds:YES];
    
    return self;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind
                                                                    atIndexPath:(NSIndexPath *)indexPath
{
   UICollectionViewLayoutAttributes * attrs;
   attrs = [super layoutAttributesForSupplementaryViewOfKind:elementKind
                                                 atIndexPath:indexPath];
   if( ![elementKind isEqualToString:UICollectionElementKindSectionFooter] ){
       return attrs;
   }

   CGRect visibleRect = [[self collectionView] bounds];
   [attrs setFrame:CGRectMake(0, visibleRect.size.height - 100,
                              visibleRect.size.width, 100)];

   return attrs;
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
