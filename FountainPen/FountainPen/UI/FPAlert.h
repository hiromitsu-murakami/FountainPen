
#import <UIKit/UIKit.h>

////////////////////////////////////////////////////////////////////////////////
// Blocks argument for Alert
//
@interface FPAlertResponse : NSObject
@property (readonly, nonatomic, strong) UIAlertView *alert; // alert view
@property (readonly, nonatomic) NSInteger index;            // selected index in all buttons
@property (readonly, nonatomic) NSInteger indexInOthers;    // selected index in other buttons
@property (readonly, nonatomic) BOOL      isCancel;         // is selected cancel button
@end


////////////////////////////////////////////////////////////////////////////////
// Blocks type for Alert
//
typedef void (^alert_block_t)(FPAlertResponse *alert);


////////////////////////////////////////////////////////////////////////////////
// AlertView for Blocks
//
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
