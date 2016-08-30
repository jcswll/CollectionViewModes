//
//  CVMShadowLayoutAttributes.h
//  CollectionViewModes
//
//  Created by Joshua Caswell on 8/29/16.
//  Copyright © 2016 Josh Caswell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CVMShadowLayoutAttributes : UICollectionViewLayoutAttributes

+ (instancetype)copyOf:(UICollectionViewLayoutAttributes *)attrs
            withShadow:(BOOL)displayShadow;

@property (assign, nonatomic) BOOL displayShadow;

@end
