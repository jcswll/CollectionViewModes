//
//  CVMOverviewLayout.m
//  CollectionViewModes
//
//  Created by Joshua Caswell on 8/19/16.
//  Copyright © 2016 Josh Caswell. All rights reserved.
//

#import "CVMOverviewLayout.h"

@implementation CVMOverviewLayout
{
    NSInteger numItems;
    CGSize itemSize;
}

- (id)init
{
    self = [super init];
    if( !self ) return nil;
    
    [self setScrollDirection:UICollectionViewScrollDirectionVertical];
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    itemSize = CGSizeMake(screenSize.width / 4,
                          screenSize.height / 4);
    [self setItemSize:itemSize];
    [self setMinimumLineSpacing:itemSize.width / 3];
    [self setMinimumInteritemSpacing:itemSize.width / 3];
    UIEdgeInsets sectionInset = UIEdgeInsetsMake(50, itemSize.width / 3,
                                                 50, itemSize.width / 3);
    [self setSectionInset:sectionInset];
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


@end
