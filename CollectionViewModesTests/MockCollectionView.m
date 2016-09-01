//
//  MockCollectionView.m
//  CollectionViewModes
//
//  Created by Joshua Caswell on 8/31/16.
//  Copyright © 2016 Josh Caswell. All rights reserved.
//

#import "MockCollectionView.h"

@implementation MockCollectionView

- (instancetype)init
{
    return self;
}

- (void)registerNib:(UINib *)nib
        forCellWithReuseIdentifier:(NSString *)identifier
{
    return;
}

@end
