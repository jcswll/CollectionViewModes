//
//  CVMRotatableLayout.h
//  CollectionViewModes
//
//  Created by Joshua Caswell on 8/25/16.
//  Copyright © 2016 Josh Caswell. All rights reserved.
//

@import UIKit;

@protocol CVMRotatableLayout <NSObject>

- (void)willTransitionToSize:(CGSize)size;

@end
