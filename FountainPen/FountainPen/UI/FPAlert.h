
#import <UIKit/UIKit.h>


@class FPAlert;

typedef void (^FPAlertBlock)(FPAlert *alert);
typedef void (^FPPresentAlertBlock)(FPAlert *alert);

// Blocksが使用できるAlertView
@interface FPAlert : UIAlertView <UIAlertViewDelegate>

@property (nonatomic, readonly) NSInteger index;
@property (nonatomic, readonly) NSInteger indexInOthers;
@property (nonatomic, readonly) BOOL      isCancel;

// OKのみのアラート（なにもしない）
+ (instancetype)showOK:(NSString *)title
               message:(NSString *)message;

// OKのみのアラート
+ (instancetype)showOK:(NSString *)title
               message:(NSString *)message
                 completion:(FPAlertBlock)block;

// キャンセルかOKかの二択のアラート
+ (instancetype)showCancelOK:(NSString *)title
                     message:(NSString *)message
                       completion:(FPAlertBlock)block;

// YES/NOの二択のアラート
+ (instancetype)showYesNo:(NSString *)title
                  message:(NSString *)message
                    completion:(FPAlertBlock)block;

// 可変長のボタン（配列）
+ (instancetype)show:(NSString *)title
             message:(NSString *)message
              cancel:(NSString *)cancel
              others:(NSArray *)others
               completion:(FPAlertBlock)block;

+ (instancetype)show:(NSString *)title
             message:(NSString *)message
              cancel:(NSString *)cancel
              others:(NSArray *)others
         willPresent:(FPPresentAlertBlock)willPresentBlock
          didPresent:(FPPresentAlertBlock)didPresentBlock
               completion:(FPAlertBlock)block;
@end
