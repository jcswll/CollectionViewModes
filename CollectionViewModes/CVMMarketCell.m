//
//  CVMMarketCell.m
//  CollectionViewModes
//
//  Created by Joshua Caswell on 8/19/16.
//  Copyright © 2016 Josh Caswell. All rights reserved.
//

#import "CVMMarketCell.h"
#import "CVMShadowLayoutAttributes.h"
#import "UIView+WSSSimpleConstraints.h"

@interface CVMMarketCell ()

/** Turn layer shadow off or on; this is used during movement in overview mode. */
- (void)setDisplaysShadow:(BOOL)display;
- (void)constructConstraints;

@end

@implementation CVMMarketCell

- (void)awakeFromNib
{
    [self constructConstraints];
}

- (void)prepareForReuse
{
    [[self name] setText:@""];
    [self setDisplaysShadow:NO];
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttrs
{
    BOOL displayShadow = NO;
    if( [layoutAttrs respondsToSelector:@selector(displayShadow)] ){
        displayShadow = [(CVMShadowLayoutAttributes *)layoutAttrs displayShadow];
    }
    // Shadow value retrieved before passing up just in case super does something stupid with the attributes object
    [super applyLayoutAttributes:layoutAttrs];
    [self setDisplaysShadow:displayShadow];
}

- (void)setDisplaysShadow:(BOOL)doesDisplay
{
    CGFloat opacity = doesDisplay ? 0.5 : 0.0;
    BOOL doesMask = !doesDisplay;
    
    [[self layer] setShadowOpacity:opacity];
    [[self layer] setMasksToBounds:doesMask];
}

- (void)constructConstraints
{
    [[self contentView] WSSCenterInSuperviewInDirections:WSSConstraintDirectionAll];
    [[self contentView] WSSFitToSuperviewInDirections:WSSConstraintDirectionAll];
}

@end
