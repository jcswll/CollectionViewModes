//
//  CVMCollectionDataSource.m
//  CollectionViewModes
//
//  Created by Joshua Caswell on 8/24/16.
//  Copyright © 2016 Josh Caswell. All rights reserved.
//

#import "CVMCollectionDataSource.h"
#import "CVMMarketCell.h"

static NSString * names[] = {@"Groceria Abbandando", 
                             @"Mercado de Luis", 
                             @"Klaus Lebensmittelmarkt"};

@implementation CVMCollectionDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CVMMarketCell * cell =
        [collectionView dequeueReusableCellWithReuseIdentifier:@"Market"
                                                  forIndexPath:indexPath];
    [[cell name] setText:names[[indexPath row]]];
    [cell layoutIfNeeded];

    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView * switchView =
        [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                           withReuseIdentifier:@"Switch"
                                                  forIndexPath:indexPath];

    return switchView;
}

@end
