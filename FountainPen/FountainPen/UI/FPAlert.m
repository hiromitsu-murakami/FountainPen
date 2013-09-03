
#if ! __has_feature(objc_arc)
#error Need "ARC" to project or "-fobjc-arc" flag to file.
#endif

#import "FPAlert.h"

#import "FPUtility.h"


@interface FPAlert () <UIAlertViewDelegate>
@property (nonatomic, copy) FPAlertBlock block;

@property (nonatomic, copy) FPPresentAlertBlock willPresentBlock;
@property (nonatomic, copy) FPPresentAlertBlock didPresentBlock;

@property (nonatomic, readwrite) NSInteger index;
@end

@implementation FPAlert

#pragma mark - lifecycle

// OKのみのアラート（なにもしない）
+ (instancetype)showOK:(NSString *)title
               message:(NSString *)message
{
    return [[self class] showOK:title
                        message:message
                     completion:nil];
}

// OKのみのアラート
+ (instancetype)showOK:(NSString *)title
               message:(NSString *)message
            completion:(FPAlertBlock)block
{
    return [[self class] show:title
                      message:message
                       cancel:@"FPOK"
                       others:nil
                   completion:block];
}

// キャンセルかOKかの二択のアラート
+ (instancetype)showCancelOK:(NSString *)title
                     message:(NSString *)message
                  completion:(FPAlertBlock)block
{
    return [[self class] show:title
                      message:message
                       cancel:L10n(@"FPCancel")
                       others:@[L10n(@"FPOK")]
                   completion:block];
}

// YES/NOの二択のアラート
+ (instancetype)showYesNo:(NSString *)title
                  message:(NSString *)message
               completion:(FPAlertBlock)block
{
    return [[self class] show:title
                      message:message
                       cancel:L10n(@"FPNo")
                       others:@[L10n(@"FPYes")]
                   completion:block];
}


// 可変長のボタン（配列）
+ (instancetype)show:(NSString *)title
             message:(NSString *)message
              cancel:(NSString *)cancel
              others:(NSArray *)others
          completion:(FPAlertBlock)block
{
    return [[self class] show:title
                      message:message
                       cancel:cancel
                       others:others
                  willPresent:nil
                   didPresent:nil
                   completion:block];
}
+ (instancetype)show:(NSString *)title
             message:(NSString *)message
              cancel:(NSString *)cancel
              others:(NSArray *)others
         willPresent:(FPPresentAlertBlock)willPresentBlock
          didPresent:(FPPresentAlertBlock)didPresentBlock
          completion:(FPAlertBlock)block
{
    // otherButtonTitlesがnilだと
    // firstOtherButtonIndexが設定されないので、１つだけ設定しておく
    NSString *first = (others.count > 0) ? others[0] : nil;
    
    // インスタンス
    FPAlert *alert = [[[self class] alloc] initWithTitle:title
                                                 message:message
                                                delegate:nil
                                       cancelButtonTitle:cancel
                                       otherButtonTitles:first, nil];
    alert.delegate = alert;
    alert.block = block;
    
    alert.willPresentBlock = willPresentBlock;
    alert.didPresentBlock  = didPresentBlock;
    
    // 残りのボタン
    for (NSString *other in others) {
        if (first != other) {
            [alert addButtonWithTitle:other];
        }
    }
    
    [alert show];
    return alert;
}

// 解放
- (void)dealloc
{
}

#pragma mark -

// Public
// selected button index in other buttons
- (NSInteger)indexInOthers
{
    return self.index - self.firstOtherButtonIndex;
}

// Public
// is selected cancel button
- (BOOL)isCancel
{
    return (self.index == self.cancelButtonIndex);
}

#pragma mark - UIAlertViewDelegate

// before animation and showing view
- (void)willPresentAlertView:(UIAlertView *)alertView
{
    FPB(self.willPresentBlock)((id)alertView);
    self.willPresentBlock = nil;
}

//// after animation
- (void)didPresentAlertView:(UIAlertView *)alertView
{
    // 通報理由の入力中にシャウトが来ると、新しいAlertViewがキーボードに隠れてしまうので
    // 強制的にキーボードを非表示にしている
    
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    [self endEditing:YES];
    
    FPB(self.didPresentBlock)((id)alertView);
    self.didPresentBlock = nil;
}

// 閉じた
- (void)alertView:(UIAlertView *)alertView
didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    FPAlert *alert = (id)alertView;
    if (![alert isKindOfClass:[FPAlert class]]) {
        return;
    }
    
    alert.index = buttonIndex;
    
    FPB(self.block)(alert);
}

@end
