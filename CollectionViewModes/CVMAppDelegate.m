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
    
    CVMCollectionViewController * controller =
        [CVMCollectionViewController controllerUsingFrame:windowFrame];
    
    UIWindow * window = [[UIWindow alloc] initWithFrame:windowFrame];
    
    [self setWindow:window];
    
    [[self window] setRootViewController:controller];
    [[self window] makeKeyAndVisible];
    
    return YES;
}

@end
