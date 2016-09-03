//
//  CVMCollectionDataSource.h
//  CollectionViewModes
//
//  Created by Joshua Caswell on 8/24/16.
//  Copyright © 2016 Josh Caswell. All rights reserved.
//

@import UIKit;

@interface CVMCollectionDataSource : NSObject <UICollectionViewDataSource>

+ (instancetype)dataSourceForView:(UICollectionView *)collectionView;

/** The new location of the given index path after items have been rearranged. */
- (NSIndexPath *)pathAfterMovementForIndexPath:(NSIndexPath *)path;

@end
