//
//  AppStoreCashAppDelegate.m
//  AppStoreCash
//
//  Created by DougT on 2/21/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "AppStoreCashAppDelegate.h"
#import "RootViewController.h"

@implementation AppStoreCashAppDelegate


@synthesize window;
@synthesize rootViewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {
    
    [window addSubview:[rootViewController view]];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [rootViewController release];
    [window release];
    [super dealloc];
}

@end
