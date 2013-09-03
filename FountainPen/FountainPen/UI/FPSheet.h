
#import <UIKit/UIKit.h>


@class FPSheet;

typedef void (^FPSheetBlock)(FPSheet *sheet);

// Blocksが使用できるActionSheet
@interface FPSheet : UIActionSheet <UIActionSheetDelegate>

@property (nonatomic, readonly) NSInteger index;
@property (nonatomic, readonly) NSInteger indexInOthers;
@property (nonatomic, readonly) BOOL      isCancel;
@property (nonatomic, readonly) BOOL      isDestructive;
@property (nonatomic, readonly) BOOL      isInvalidIndex;

+ (instancetype)show:(NSString *)title
              cancel:(NSString *)cancelButtonTitle
         destructive:(NSString *)destructiveButtonTitle
              others:(NSArray *)otherButtonTitles
          completion:(FPSheetBlock)block;
@end
