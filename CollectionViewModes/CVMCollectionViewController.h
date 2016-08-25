//
//  CVMCollectionViewController.h
//  CollectionViewModes
//
//  Created by Joshua Caswell on 8/24/16.
//  Copyright © 2016 Josh Caswell. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CVMCollectionDataSource;

@interface CVMCollectionViewController : UICollectionViewController

+ controllerWithDataSource:(CVMCollectionDataSource *)dataSource;

@end
