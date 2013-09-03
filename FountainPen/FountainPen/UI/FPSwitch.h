
#import <UIKit/UIKit.h>


@class FPSwitch;

typedef void (^FPSwitchBlock)(FPSwitch *sw);

@interface FPSwitch : UISwitch

// Create FPSwitch instance.
//    block: Run block if value changed.
+ (instancetype)createWithFrame:(CGRect)frame
                          block:(FPSwitchBlock)block;

@end
