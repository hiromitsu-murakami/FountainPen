
#import <UIKit/UIKit.h>

////////////////////////////////////////////////////////////////////////////////
// Blocks argument for Alert
@interface FPAlertResponse : NSObject
@property (readonly, nonatomic, strong) UIAlertView *alert;
@property (readonly, nonatomic)         NSInteger   index;
@property (readonly, nonatomic)         BOOL        isCancel;
@end


////////////////////////////////////////////////////////////////////////////////
// Blocks type for Alert
typedef void (^alert_block_t)(FPAlertResponse *alert);


////////////////////////////////////////////////////////////////////////////////
// AlertView for Blocks
@interface FPAlert : UIAlertView

// OK only
+ (FPAlert *)showOK:(NSString *)title
            message:(NSString *)message;

// OK only + Blocks
// Call Blocks after dissmissed
+ (FPAlert *)showOK:(NSString *)title
            message:(NSString *)message
         completion:(alert_block_t)block;

// Show Alert
// Call Blocks after dismissed
+ (FPAlert *)show:(NSString *)title
          message:(NSString *)message
           cancel:(NSString *)cancelButtonTitle
           others:(NSArray *)otherButtonTitles
       completion:(alert_block_t)block;
@end
