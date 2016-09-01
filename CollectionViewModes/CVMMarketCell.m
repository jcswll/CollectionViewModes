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

- (void)constructConstraints
{
    [[self contentView] 
        WSSCenterInSuperviewInDirections:WSSConstraintDirectionAll];
    [[self contentView] 
        WSSFitToSuperviewInDirections:WSSConstraintDirectionAll];
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttrs
{
    BOOL displayShadow = NO;
    if( [layoutAttrs respondsToSelector:@selector(displayShadow)] ){
        displayShadow = [(CVMShadowLayoutAttributes *)layoutAttrs displayShadow];
    }
        
    [self setDisplaysShadow:displayShadow];
    [super applyLayoutAttributes:layoutAttrs];
}

- (void)setDisplaysShadow:(BOOL)display
{
    CGFloat opacity = display ? 0.5 : 0.0;
    BOOL doesMask = !display;
    
    [[self layer] setShadowOpacity:opacity];
    [[self layer] setMasksToBounds:doesMask];
}

@end
