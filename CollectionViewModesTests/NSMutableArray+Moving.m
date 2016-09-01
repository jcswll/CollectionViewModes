//
//  NSMutableArray+Moving.m
//  CollectionViewModes
//
//  Created by Joshua Caswell on 8/31/16.
//  Copyright © 2016 Josh Caswell. All rights reserved.
//

#import "NSMutableArray+Moving.h"

@implementation NSMutableArray (Moving)

- (void)WSSMoveObjectAtIndex:(NSUInteger)fromIndex
                     toIndex:(NSUInteger)toIndex
{
    id object = self[fromIndex];
    [self removeObjectAtIndex:fromIndex];
    [self insertObject:object atIndex:toIndex];
}

@end
