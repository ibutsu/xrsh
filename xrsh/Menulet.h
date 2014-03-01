//
//  Menulet.h
//  xrsh
//
//  Created by Kairi Izumi on 28/02/2014.
//  Copyright (c) 2014 Cuties' Egalitarian Front. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Menulet : NSObject

@property (nonatomic, retain) NSStatusItem *statusItem;
@property (nonatomic, retain) IBOutlet NSMenu *menu;

@end
