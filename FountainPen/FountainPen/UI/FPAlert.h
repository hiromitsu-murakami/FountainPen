
#import <UIKit/UIKit.h>


@class FPAlert;

typedef void (^FPAlertBlock)(FPAlert *alert);
typedef void (^FPPresentAlertBlock)(FPAlert *alert);

// Blocksが使用できるAlertView
@interface FPAlert : UIAlertView <UIAlertViewDelegate>

@property (nonatomic, readonly) NSInteger index;
@property (nonatomic, readonly) NSInteger indexInOthers;
@property (nonatomic, readonly) BOOL      isCancel;

+ (instancetype)showOK:(NSString *)title
               message:(NSString *)message;

+ (instancetype)showOK:(NSString *)title
               message:(NSString *)message
                 completion:(FPAlertBlock)block;

+ (instancetype)showCancelOK:(NSString *)title
                     message:(NSString *)message
                       completion:(FPAlertBlock)block;

+ (instancetype)showYesNo:(NSString *)title
                  message:(NSString *)message
                    completion:(FPAlertBlock)block;

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
