//
//  Menulet.m
//  xrsh
//
//  Created by Kairi Izumi on 28/02/2014.
//  Copyright (c) 2014 Cuties' Egalitarian Front. All rights reserved.
//

#import "Menulet.h"

@implementation Menulet

NSWindowController *prefWindow;

- (void)awakeFromNib
{
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength: NSVariableStatusItemLength];
    [self.statusItem setHighlightMode: YES];
    [self.statusItem setTitle: @"相人時"];
    [self.statusItem setEnabled: YES];
    [self.statusItem setMenu: self.menu];
    
    prefWindow = [[NSWindowController alloc] initWithWindowNibName:@"Preferences"];
    
    [self initClock];
}

- (void)refreshClock:(NSTimer*)timer
{
    NSString *formattedDate = [[timer userInfo] stringFromDate: [[NSDate alloc] init]];
    [self.statusItem setTitle: formattedDate];
}

- (void)initClock
{
    NSTimeZone *tz = [[NSTimeZone alloc] initWithName: @"Australia/Melbourne"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"HH:mm"];
    [dateFormatter setTimeZone: tz];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshClock:) userInfo:dateFormatter repeats:YES];
}

- (IBAction)showPreferences:(id)sender
{
    [prefWindow showWindow:nil];
}

- (IBAction)quit:(id)sender
{
    [NSApp terminate: sender];
}

@end
