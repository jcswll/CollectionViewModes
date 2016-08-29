//
//  CVMMarketCell.m
//  CollectionViewModes
//
//  Created by Joshua Caswell on 8/19/16.
//  Copyright © 2016 Josh Caswell. All rights reserved.
//

#import "CVMMarketCell.h"
#import "UIView+WSSSimpleConstraints.h"

@implementation CVMMarketCell
{
    BOOL haveConstraints;
}

- (void)prepareForReuse
{
    [[self name] setText:@""];
}

- (void)didMoveToSuperview
{
    // Will also be called when removing from hierarchy; superview will be nil
    if( [self superview] && !haveConstraints ){
        
        [[self contentView] setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self constructConstraints];
        [self layoutIfNeeded];
    }
}

- (void)constructConstraints
{
    [[self contentView] 
        WSSCenterInSuperviewInDirections:WSSConstraintDirectionAll];
    [[self contentView] 
        WSSFitToSuperviewInDirections:WSSConstraintDirectionAll];
    
    haveConstraints = YES;
}

@end
