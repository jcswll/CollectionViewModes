//
//  CVMFullscreenLayout.h
//  CollectionViewModes
//
//  Created by Joshua Caswell on 8/23/16.
//  Copyright © 2016 Josh Caswell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CVMFullscreenLayout : UICollectionViewFlowLayout

+ (instancetype)layoutWithSize:(CGSize)layoutSize;

@property (assign, nonatomic) NSUInteger pageIndex;

- (void)updatePageIndex;

@end
