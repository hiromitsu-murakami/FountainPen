
#if ! __has_feature(objc_arc)
#error Need "ARC" to project or "-fobjc-arc" flag to file.
#endif

#import "FPSheet.h"

#import "FPUtility.h"


@interface FPSheet ()
@property (nonatomic, copy) FPSheetBlock block;

@property (nonatomic, readwrite) NSInteger index;
@end

@implementation FPSheet

#pragma mark - lifecycle

// 可変長のボタン（配列）
// （配列を可変長引数に変換できる方法が分かるのであれば書き直す）
+ (instancetype)show:(NSString *)title
              cancel:(NSString *)cancel
         destructive:(NSString *)destructive
              others:(NSArray *)others
          completion:(FPSheetBlock)aBlock
{
    // otherButtonTitlesがnilだと
    // firstOtherButtonIndexが設定されないので、１つだけ設定しておく
    NSString *first = ([others count]) > 0 ? others[0] : nil;
    
    // インスタンス
    FPSheet *action = [[[self class] alloc] initWithTitle:title
                                                  delegate:nil
                                         cancelButtonTitle:nil
                                    destructiveButtonTitle:destructive
                                         otherButtonTitles:first, nil];
    action.delegate = action;
    action.block = aBlock;
    
    // 残りのボタン
    for (NSString *other in others) {
        if (first != other) {
            [action addButtonWithTitle:other];
        }
    }
    
    // キャンセルボタンは最後に追加しないとならない
    if (cancel) {
        [action addButtonWithTitle:cancel];
        action.cancelButtonIndex = (destructive ? 1 : 0) + [others count];
    }
    
    UIWindow *window = [self.class currentWindow];
    [action showInView:window];
    return action;
}

// keyWindow を使うと意図しない window に表示される可能性がある
+ (UIWindow *)currentWindow
{
    id <UIApplicationDelegate> appDelegate = [[UIApplication sharedApplication] delegate];
    if ([appDelegate respondsToSelector:@selector(window)]) {
        return appDelegate.window;
    } else {
        return [[UIApplication sharedApplication] keyWindow];
    }
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

// Public
// is selected destructive button
- (BOOL)isDestructive
{
    return (self.index == self.destructiveButtonIndex);
}

- (BOOL)isInvalidIndex
{
    return (self.firstOtherButtonIndex < 0);
}

#pragma mark - UIActionSheetDelegate

// 閉じた
- (void)actionSheet:(UIActionSheet *)actionSheet
didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    FPSheet *sheet = (id)actionSheet;
    if (![sheet isKindOfClass:[FPSheet class]]) {
        return;
    }
    
    sheet.index = buttonIndex;
    
    FPB(self.block)(sheet);
}

@end
