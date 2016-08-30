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

@interface CVMCollectionDataSource ()

- (void)registerViewsWithCollectionView:(UICollectionView *)collectionView;

@end

@implementation CVMCollectionDataSource
{
    NSMutableArray * names;
}

+ (instancetype)dataSourceForView:(UICollectionView *)collectionView    
{
    return [[self alloc] initForView:collectionView];
}
                             
- (instancetype)initForView:(UICollectionView *)collectionView
{
    self = [super init];
    if( !self ) return nil;
    
    names = [@[@"Groceria Abbandando",
               @"Mercado de Luis",
               @"Klaus Lebensmittelmarkt",
               @"Épicerie Pierre",
               @"Doyle's Grocery",
               @"Hans supermarkt",
               @"Mercearia de João",
               @"प्रसाद की किराने की दुकान"] mutableCopy];

    [self registerViewsWithCollectionView:collectionView];
    
    return self;
}
                             
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
    return [names count];
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

- (void)collectionView:(UICollectionView *)collectionView
   moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath
           toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSUInteger sourceIndex = [sourceIndexPath row];
    NSUInteger destinationIndex = [destinationIndexPath row];
    NSString * movingItem = names[sourceIndex];
    [names removeObjectAtIndex:sourceIndex];
    [names insertObject:movingItem atIndex:destinationIndex];
}

@end
