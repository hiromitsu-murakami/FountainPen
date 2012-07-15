
#import <UIKit/UIKit.h>

////////////////////////////////////////////////////////////////////////////////
// Blocks argument for Sheet
//
@interface FPSheetResponse : NSObject
@property (readonly, nonatomic, strong) UIActionSheet *sheet;
@property (readonly, nonatomic)         NSInteger     index;
@property (readonly, nonatomic)         BOOL          isCancel;
@property (readonly, nonatomic)         BOOL          isDestructive;
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
