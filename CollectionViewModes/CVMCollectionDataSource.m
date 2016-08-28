//
//  CVMCollectionDataSource.m
//  CollectionViewModes
//
//  Created by Joshua Caswell on 8/24/16.
//  Copyright © 2016 Josh Caswell. All rights reserved.
//

#import "CVMCollectionDataSource.h"
#import "CVMMarketCell.h"

static NSString * const kMarketCellNibName = @"MarketCell";
static NSString * const kMarketCellReuseIdentifier = @"MarketCell";

static NSString * names[] = {@"Groceria Abbandando",
                             @"Mercado de Luis",
                             @"Klaus Lebensmittelmarkt",
                             @"Épicerie Pierre",
                             @"Doyle's Grocery",
                             @"Hans supermarkt",
                             @"Mercearia de João",
                             @"प्रसाद की किराने की दुकान"};
/////////////////////////////////////////////////////////////////////////////

@implementation CVMCollectionDataSource
                             
- (void)registerViewsWithCollectionView:(UICollectionView*)collectionView
{
    UINib * cellNib = [UINib nibWithNibName:kMarketCellNibName
                                     bundle:nil];
    [collectionView registerNib:cellNib
                  forCellWithReuseIdentifier:kMarketCellReuseIdentifier];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return sizeof(names) / sizeof(NSString *);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CVMMarketCell * cell =
        [collectionView dequeueReusableCellWithReuseIdentifier:kMarketCellReuseIdentifier
                                                  forIndexPath:indexPath];
    [[cell name] setText:names[[indexPath row]]];
    [cell layoutIfNeeded];

    return cell;
}

@end
