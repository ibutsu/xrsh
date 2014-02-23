//
//  AppDelegate.m
//  xrsh
//
//  Created by Kairi Izumi on 23/02/2014.
//  Copyright (c) 2014 Cuties' Egalitarian Front. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSDate *date = [[NSDate alloc] init];
    NSLog(@"date: %@", date);
    
    NSTimeZone *tz = [NSTimeZone systemTimeZone];
    NSLog(@"timezone: %@", tz);
}

@end
