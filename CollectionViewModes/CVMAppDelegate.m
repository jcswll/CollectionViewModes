//
//  CVMAppDelegate.m
//  CollectionViewModes
//
//  Created by Joshua Caswell on 8/19/16.
//  Copyright © 2016 Josh Caswell. All rights reserved.
//

#import "CVMAppDelegate.h"
#import "CVMCollectionDataSource.h"
#import "CVMCollectionViewController.h"

@implementation CVMAppDelegate

- (BOOL)application:(UIApplication *)application
        didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{    
    CGRect windowFrame = [[UIScreen mainScreen] bounds];
    UIWindow * window = [[UIWindow alloc] initWithFrame:windowFrame];
    
    [self setWindow:window];
    
    CVMCollectionDataSource * dataSource = [CVMCollectionDataSource new];
    
    CVMCollectionViewController * controller =
        [CVMCollectionViewController controllerWithDataSource:dataSource];
    
    [[self window] setRootViewController:controller];
    [[self window] makeKeyAndVisible];
    
    return YES;
}

@end
