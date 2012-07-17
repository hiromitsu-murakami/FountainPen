
#import <UIKit/UIKit.h>

////////////////////////////////////////////////////////////////////////////////
// Blocks argument for Sheet
//
@interface FPSheetResponse : NSObject
@property (readonly, nonatomic, strong) UIActionSheet *sheet;   // action sheet
@property (readonly, nonatomic) NSInteger index;          // selected index in all buttons
@property (readonly, nonatomic) NSInteger indexInOthers;  // selected index in other buttons
@property (readonly, nonatomic) BOOL      isCancel;       // is selected cancel button
@property (readonly, nonatomic) BOOL      isDestructive;  // is selected destructive button
@end


////////////////////////////////////////////////////////////////////////////////
// Blocks type for Sheet
//
typedef void (^sheet_block_t)(FPSheetResponse *sheet);


////////////////////////////////////////////////////////////////////////////////
// ActionSheet for Blocks
//
@interface FPSheet : UIActionSheet

// Show Sheet
// Call Blocks after dismissed
+ (FPSheet *)show:(NSString *)title
           cancel:(NSString *)cancelButtonTitle
      destructive:(NSString *)destructiveButtonTitle
           others:(NSArray *)otherButtonTitles
       completion:(sheet_block_t)block;
@end
