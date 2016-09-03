//
//  CVMShadowLayoutAttributes.h
//  CollectionViewModes
//
//  Created by Joshua Caswell on 8/29/16.
//  Copyright © 2016 Josh Caswell. All rights reserved.
//

@import UIKit;

/**
 * Layout attributes for a collection view element, specifying whether the view should display a shadow.
 *
 * This is used by \c CVMOverviewLayout when a cell is being moved around.
 */
@interface CVMShadowLayoutAttributes : UICollectionViewLayoutAttributes

/** An instance with all inherited properties set to the values found in \c attrs, plus the given \c displayShadow value. */
+ (instancetype)copyOf:(UICollectionViewLayoutAttributes *)attrs
            withShadow:(BOOL)displayShadow;

/** Indicator for whether the view should make its layer's shadow visible. The specific parameters are up to the view. */
@property (assign, nonatomic) BOOL displayShadow;

@end
