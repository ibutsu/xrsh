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
    [[NSUserDefaults standardUserDefaults] addObserver:self
                                            forKeyPath:@"24hour"
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
    NSString *dateFormat = [[[NSUserDefaults standardUserDefaults] valueForKey:@"24hour"] isEqual:@NO] ? @"h:mm a" : @"HH:mm";
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: dateFormat];
    [dateFormatter setTimeZone: tz];
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshClock:) userInfo:dateFormatter repeats:YES];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context {
    NSString *newValue = change[NSKeyValueChangeNewKey];
    NSLog(@"KVO: property %@ changed to %@", keyPath, newValue);
    
    if ([keyPath isEqualToString: @"timezone"]) {
        [dateFormatter setTimeZone: [[NSTimeZone alloc] initWithName:newValue]];
    } else if ([keyPath isEqualToString: @"24hour"]) {
        NSString *dateFormat = [newValue isEqual:@NO] ? @"h:mm a" : @"HH:mm";
        [dateFormatter setDateFormat: dateFormat];
    }
    
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
                                               forKeyPath:@"24hour"];
    [[NSUserDefaults standardUserDefaults] removeObserver:self
                                               forKeyPath:@"timezone"];
}

@end
