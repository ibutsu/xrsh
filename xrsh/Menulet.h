#import <Foundation/Foundation.h>

@interface Menulet : NSObject

@property (nonatomic, retain) NSStatusItem *statusItem;
@property (nonatomic, retain) IBOutlet NSMenu *menu;

@end
