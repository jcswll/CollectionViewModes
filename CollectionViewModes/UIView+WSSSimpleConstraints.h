//
//  UIView+WSSSimpleConstraints.h
//
//  Created by Joshua Caswell on 10/14/15.
//  Copyright © 2015 Josh Caswell. All rights reserved.
//

#import <UIKit/UIKit.h>

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

- (void)WSSFitToSuperviewInDirections:(WSSConstraintDirection)directions;

- (void)WSSSpaceAtStandardDistanceFromSuperviewInDirections:
                                            (WSSConstraintDirection)directions;

- (void)WSSSpaceAtDistance:(CGFloat)space
 fromSuperviewInDirections:(WSSConstraintDirection)directions;

- (void)WSSCenterInSuperviewInDirections:(WSSConstraintDirection)directions;

@end
