//
//  CVMMarketCell.m
//  CollectionViewModes
//
//  Created by Joshua Caswell on 8/19/16.
//  Copyright © 2016 Josh Caswell. All rights reserved.
//

#import "CVMMarketCell.h"

@implementation CVMMarketCell

- (void)prepareForReuse
{
    [[self name] setText:@""];
}

- (void)didMoveToSuperview
{
    // Will also be called when removing from hierarchy; superview will be nil
    if( [self superview] ){
        
        [[self contentView] setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self constructConstraints];
        [self layoutIfNeeded];
    }
}

- (void)constructConstraints
{
    UIView * contentView = [self contentView];
    NSArray * constraints = @[
                              [NSLayoutConstraint constraintWithItem:contentView
                                                           attribute:NSLayoutAttributeHeight
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self
                                                           attribute:NSLayoutAttributeHeight
                                                          multiplier:1.0
                                                            constant:0.0],
                              [NSLayoutConstraint constraintWithItem:contentView
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self
                                                           attribute:NSLayoutAttributeTop
                                                          multiplier:1.0
                                                            constant:0.0],
                              [NSLayoutConstraint constraintWithItem:contentView
                                                           attribute:NSLayoutAttributeLeading
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self
                                                           attribute:NSLayoutAttributeLeading
                                                          multiplier:1.0
                                                            constant:0.0],
                              [NSLayoutConstraint constraintWithItem:contentView
                                                           attribute:NSLayoutAttributeWidth
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self
                                                           attribute:NSLayoutAttributeWidth
                                                          multiplier:1.0
                                                            constant:0.0]];
    
    [NSLayoutConstraint activateConstraints:constraints];
}

//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if( !self ) return nil;
//    
//    UILabel * label = [[UILabel alloc] initWithFrame:CGRectZero];
//    UIView * dummy = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    [label setTranslatesAutoresizingMaskIntoConstraints:NO];
//    [dummy setBackgroundColor:[UIColor redColor]];
//    [[self contentView] addSubview:dummy];
//    [dummy addSubview:label];
//    _name = label;
//    
//    [[NSLayoutConstraint constraintWithItem:_name
//                                  attribute:NSLayoutAttributeCenterX
//                                  relatedBy:NSLayoutRelationEqual
//                                     toItem:[self contentView]
//                                  attribute:NSLayoutAttributeCenterX
//                                 multiplier:1.0
//                                   constant:0.0] setActive:YES];
//    [[NSLayoutConstraint constraintWithItem:_name
//                                  attribute:NSLayoutAttributeCenterY
//                                  relatedBy:NSLayoutRelationEqual
//                                     toItem:[self contentView]
//                                  attribute:NSLayoutAttributeCenterY
//                                 multiplier:1.0
//                                   constant:0.0] setActive:YES];
//    
//    return self;
//}

@end
