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
}

- (id)init
{
    self = [super init];
    if( !self ) return nil;
    
    [self setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    [self setItemSize:screenSize];
    // "Line" spacing is between _columns_ for horizontal scrolling
    [self setMinimumLineSpacing:0];
    [self setSectionInset:UIEdgeInsetsZero];
    [self setFooterReferenceSize:CGSizeMake(100, 0)];
    [self setSectionFootersPinToVisibleBounds:YES];
    
    return self;
}

- (void)prepareLayout
{
    [super prepareLayout];

    numItems = [[self collectionView] numberOfItemsInSection:0];
}

- (CGSize)collectionViewContentSize
{
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    return CGSizeMake(screenSize.width * numItems, screenSize.height);
}
//
//- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind
//                                                                    atIndexPath:(NSIndexPath *)indexPath
//{
//   UICollectionViewLayoutAttributes * attrs;
//   attrs = [super layoutAttributesForSupplementaryViewOfKind:elementKind
//                                                 atIndexPath:indexPath];
//   if( ![elementKind isEqualToString:UICollectionElementKindSectionFooter] ){
//       return attrs;
//   }
//
//   CGRect visibleRect = [[self collectionView] bounds];
//   [attrs setFrame:CGRectMake(0, visibleRect.size.height - 100,
//                              visibleRect.size.width, 100)];
//
//   return attrs;
//}

@end
