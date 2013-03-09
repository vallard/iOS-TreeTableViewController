//
//  TTAppDelegate.m
//  TreeTableView
//
//  Created by Vallard Benincosa on 2/25/13.
//  Copyright (c) 2013 Vallard Benincosa. All rights reserved.
//

#import "TTAppDelegate.h"

@implementation TTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];    
    // sample Dictionary
    NSArray *sampleArray = @[ @"1",
                              @"2",
                            @[@"3",
                                @[@"3-1", @"3-1-1", @"3-1-2" ] , @"3-2", @"3-3", @"3-4"],
                              @"4",
                              @"5",
                              @"6"];
    
    NSArray *servers =  @[@"Servers", @"server 1", @"server 2", @"server 3"];
    
    NSArray *backplainPorts = @[@"BackPlane Ports", @"Backplane Port 1/1", @"Backplane Port 1/2", @"Backplane Port 1/3"];
    NSArray *fabricPorts = @[@"Fabric Ports", @"Fabric Port 1/1", @"Fabric Port 1/2"];
    NSArray *iomodules = @[@"IO Modules", @[@"IO Module 1", backplainPorts, fabricPorts], @[@"IO Module 2", backplainPorts, fabricPorts]];
    NSArray *chassisArray = @[@"Chassis", @[@"Chassis 1", iomodules, servers], @[@"Chassis 2", iomodules, servers]];
    NSArray *equipmentArray = @[@[@"Equipment", chassisArray, sampleArray, sampleArray]];
    
   // Create Example Tree Table
    //TTExampleTreeTableViewController *ttable = [[TTExampleTreeTableViewController alloc] initWithArray:sampleArray];
    TTExampleTreeTableViewController *ttable = [[TTExampleTreeTableViewController alloc] initWithArray:equipmentArray];
    self.window.rootViewController = ttable;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
