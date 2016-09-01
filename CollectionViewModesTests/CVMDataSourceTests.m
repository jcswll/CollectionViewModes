//
//  CVMCollectionDataSourceTests.m
//  CVMCollectionDataSourceTests
//
//  Created by Joshua Caswell on 8/31/16.
//  Copyright © 2016 Josh Caswell. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CVMCollectionDataSource.h"
#import "MockCollectionView.h"
#import "NSMutableArray+Moving.h"

@interface CVMCollectionDataSourceTests : XCTestCase

@end

@implementation CVMCollectionDataSourceTests
{
    CVMCollectionDataSource * dataSource;
    MockCollectionView * collectionView;
    NSUInteger numItems;
}

- (void)setUp
{
    [super setUp];
    collectionView = [MockCollectionView new];
    dataSource = [CVMCollectionDataSource dataSourceForView:collectionView];
    numItems = [dataSource collectionView:collectionView
                   numberOfItemsInSection:0];
}

- (void)checkAllRowsExpecting:(NSArray<NSNumber *> *)rowValues
{
    for( NSUInteger row = 0; row < numItems; row++ ){

        NSIndexPath * checkPath = [NSIndexPath indexPathForRow:row
                                                     inSection:0];
        NSIndexPath * movedPath = [dataSource postMovementIndexPath:checkPath];

        NSUInteger expectedRow = [rowValues[row] unsignedIntegerValue];
        NSIndexPath * expectedPath = [NSIndexPath indexPathForRow:expectedRow
                                                        inSection:0];
        XCTAssertEqual(expectedPath, movedPath,
                       @"Expected row: %lu; got: %lu",
                       [expectedPath row], [movedPath row]);
    }
}

- (NSArray<NSNumber *> *)
    positionsAfterMovingObjectAtIndex:(NSUInteger)fromIndex
                              toIndex:(NSUInteger)toIndex
{
    NSMutableArray * objects = [NSMutableArray array];
    for( NSUInteger index = 0; index < numItems; index++ ){
        [objects addObject:[NSObject new]];
    }

    NSArray * objectsInOriginalOrder = [objects copy];
    [objects WSSMoveObjectAtIndex:fromIndex toIndex:toIndex];

    NSMutableArray<NSNumber *> * positions = [NSMutableArray array];
    for( NSObject * object in objectsInOriginalOrder ){
        NSUInteger position = [objects indexOfObjectIdenticalTo:object];
        [positions addObject:@(position)];
    }

    return positions;
}

- (void)testIndexPathMovementNoMovement
{
    for( NSUInteger row = 0; row < numItems; row++ ){

        NSIndexPath * sourcePath = [NSIndexPath indexPathForRow:row
                                                      inSection:0];
        NSIndexPath * destinationPath = sourcePath;

        [dataSource collectionView:collectionView
               moveItemAtIndexPath:sourcePath
                       toIndexPath:destinationPath];

        NSArray<NSNumber *> * expectedRows =
            [self positionsAfterMovingObjectAtIndex:[sourcePath row]
                                            toIndex:[destinationPath row]];
        [self checkAllRowsExpecting:expectedRows];
    }
}

- (void)testIndexPathMovementFirstToLast
{
    NSIndexPath * sourcePath = [NSIndexPath indexPathForRow:0
                                                  inSection:0];
    NSIndexPath * destinationPath = [NSIndexPath indexPathForRow:numItems - 1
                                                       inSection:0];

    [dataSource collectionView:collectionView
           moveItemAtIndexPath:sourcePath
                   toIndexPath:destinationPath];

    NSArray<NSNumber *> * expectedRows =
        [self positionsAfterMovingObjectAtIndex:[sourcePath row]
                                        toIndex:[destinationPath row]];
    [self checkAllRowsExpecting:expectedRows];
}

- (void)testIndexPathMovementLastToFirst
{
    NSIndexPath * sourcePath = [NSIndexPath indexPathForRow:numItems - 1
                                                  inSection:0];
    NSIndexPath * destinationPath = [NSIndexPath indexPathForRow:0
                                                       inSection:0];

    [dataSource collectionView:collectionView
           moveItemAtIndexPath:sourcePath
                   toIndexPath:destinationPath];

    NSArray<NSNumber *> * expectedRows =
        [self positionsAfterMovingObjectAtIndex:[sourcePath row]
                                        toIndex:[destinationPath row]];
    [self checkAllRowsExpecting:expectedRows];
}

- (void)testIndexPathMovementAllMovements
{
    NSMutableArray * pairs = [NSMutableArray array];
    for( NSUInteger source = 0; source < numItems; source++ ){
        for( NSUInteger dest = 0; dest < numItems; dest++ ){

            if( dest == source ) continue;

            [pairs addObject:@[@(source), @(dest)]];
        }
    }

    for( NSArray * pair in pairs ){

        NSUInteger sourceIndex = [pair[0] unsignedIntegerValue];
        NSUInteger destinationIndex = [pair[1] unsignedIntegerValue];
        NSIndexPath * sourcePath = [NSIndexPath indexPathForRow:sourceIndex
                                                      inSection:0];
        NSIndexPath * destinationPath = [NSIndexPath indexPathForRow:destinationIndex
                                                           inSection:0];

        [dataSource collectionView:collectionView
               moveItemAtIndexPath:sourcePath
                       toIndexPath:destinationPath];

        NSArray<NSNumber *> * expectedRows =
            [self positionsAfterMovingObjectAtIndex:sourceIndex
                                            toIndex:destinationIndex];
        [self checkAllRowsExpecting:expectedRows];
    }
}

@end
