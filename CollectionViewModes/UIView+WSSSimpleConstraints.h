//
//  UIView+WSSSimpleConstraints.h
//
//  Created by Joshua Caswell on 10/14/15.
//  Copyright © 2015 Josh Caswell. All rights reserved.
//

@import UIKit;

typedef NS_OPTIONS(NSUInteger, WSSConstraintDirection) {
    WSSConstraintDirectionLeft = 1 << 0,
    WSSConstraintDirectionUp = 1 << 1,
    WSSConstraintDirectionRight = 1 << 2,
    WSSConstraintDirectionDown = 1 << 3,
    
    WSSConstraintDirectionHorizontal = (1 << 0) | (1 << 2),
    WSSConstraintDirectionVertical = (1 << 1) | (1 << 3),
    
    WSSConstraintDirectionAll = 0x0F,
};

@interface UIView (WSSSimpleConstraints)

/** This view and its superview are constrained to have their edges equal in the given directions. */
- (void)WSSFitToSuperviewInDirections:(WSSConstraintDirection)directions;

/** This view is constrained inset from its superview by the standard distance represented by "-" in the Auto Layout VFL. */
- (void)WSSSpaceAtStandardDistanceFromSuperviewInDirections:(WSSConstraintDirection)directions;

/** This view is constrained inset from its superview by the given amount in the given directions. */
- (void)WSSSpaceAtDistance:(CGFloat)space
 fromSuperviewInDirections:(WSSConstraintDirection)directions;

/**
 * This view and its superview are constrained to have center positions equal in the given directions.
 *
 * \c directions must be one or both of \c WSSConstraintDirectionHorizontal and \c WSSConstraintDirectionVertical. 
 */
- (void)WSSCenterInSuperviewInDirections:(WSSConstraintDirection)directions;

@end
