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
NSDateFormatter *dateFormatter;

- (void)awakeFromNib
{
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength: NSVariableStatusItemLength];
    [self.statusItem setHighlightMode: YES];
    [self.statusItem setTitle: @"相人時"];
    [self.statusItem setEnabled: YES];
    [self.statusItem setMenu: self.menu];
    
    [[NSUserDefaults standardUserDefaults] addObserver:self
                                            forKeyPath:@"timezone"
                                               options:NSKeyValueObservingOptionNew
                                               context:NULL];
    
    [self initClock];
}

- (void)refreshClock:(NSTimer*)timer
{
    NSString *formattedDate = [[timer userInfo] stringFromDate: [[NSDate alloc] init]];
    [self.statusItem setTitle: formattedDate];
}

- (void)initClock
{
    NSTimeZone *tz = [[NSTimeZone alloc] initWithName: [[NSUserDefaults standardUserDefaults] valueForKey:@"timezone"]];
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"HH:mm"];
    [dateFormatter setTimeZone: tz];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshClock:) userInfo:dateFormatter repeats:YES];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context {
    // called on every change. (if you called addObserver: multiple times
    // for different keys, check "keyPath" to see which one changed.)
    NSString *newValue = change[NSKeyValueChangeNewKey];
    NSLog(@"KVO: property %@ changed to %@", keyPath, newValue);
    [dateFormatter setTimeZone: [[NSTimeZone alloc] initWithName:newValue]];
}

- (IBAction)showPreferences:(id)sender
{
    prefWindow = [[NSWindowController alloc] initWithWindowNibName:@"Preferences"];
    [prefWindow showWindow:nil];
    [prefWindow.window makeKeyAndOrderFront:nil];
}

- (IBAction)quit:(id)sender
{
    [NSApp terminate: sender];
}

- (void)dealloc
{
    [[NSUserDefaults standardUserDefaults] removeObserver:self
                                               forKeyPath:@"timezone"];
}

@end
