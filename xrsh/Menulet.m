//
//  Menulet.m
//  xrsh
//
//  Created by Kairi Izumi on 28/02/2014.
//  Copyright (c) 2014 Cuties' Egalitarian Front. All rights reserved.
//

#import "Menulet.h"

@implementation Menulet

- (void)awakeFromNib
{
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength: NSVariableStatusItemLength];
    [self.statusItem setHighlightMode: YES];
    [self.statusItem setTitle: @"相人時"];
    [self.statusItem setEnabled: YES];
    [self.statusItem setMenu: self.menu];
}

- (IBAction)initClock:(id)sender
{
    NSTimeZone *tz= [[NSTimeZone alloc] initWithName: @"Australia/Melbourne"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"HH:mm"];
    [dateFormatter setTimeZone: tz];
    
    NSDate *date = [[NSDate alloc] init];
    NSString *formattedDate = [dateFormatter stringFromDate:date];
    [self.statusItem setTitle: formattedDate];
}

- (IBAction)refreshClock
{
    // ???
}

- (IBAction)quit:(id)sender
{
    [NSApp terminate: sender];
}

@end
