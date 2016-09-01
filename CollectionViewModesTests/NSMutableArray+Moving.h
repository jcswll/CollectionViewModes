//
//  NSMutableArray+Moving.h
//  CollectionViewModes
//
//  Created by Joshua Caswell on 8/31/16.
//  Copyright © 2016 Josh Caswell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Moving)

- (void)WSSMoveObjectAtIndex:(NSUInteger)fromIndex
                     toIndex:(NSUInteger)toIndex;

@end
