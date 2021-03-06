//
//  CVMMarketCell.h
//  CollectionViewModes
//
//  Created by Joshua Caswell on 8/19/16.
//  Copyright © 2016 Josh Caswell. All rights reserved.
//

@import UIKit;

@interface CVMMarketCell : UICollectionViewCell

@property (weak, nonatomic, nullable) UIView * tableView;
@property (assign, nonatomic, getter=isInOverview) BOOL inOverview;

@end
