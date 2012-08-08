
#import "FPAlert.h"

#if ! __has_feature(objc_arc)
#error Need "ARC" to project or "-fobjc-arc" flag to file.
#endif

////////////////////////////////////////////////////////////////////////////////
#pragma mark - FPAlertResponse Class

@interface FPAlertResponse ()
@property (readwrite, nonatomic, strong) UIAlertView *alert;
@property (readwrite, nonatomic)         NSInteger   index;
@end

@implementation FPAlertResponse
@synthesize alert = _alert;
@synthesize index = _index;
@dynamic    indexInOthers;
@dynamic    isCancel;

// Convenience
+ (FPAlertResponse *)createWithAlert:(UIAlertView *)alert
                               index:(NSInteger)index
{
    return [[[self class] alloc] initWithAlert:alert index:index];
}

// initial
- (id)initWithAlert:(UIAlertView *)alert
              index:(NSInteger)index
{
    self = [super init];
    if (self) {
        self.alert = alert;
        self.index = index;
    }
    return self;
}

// Public
// selected button index in other buttons
- (NSInteger)indexInOthers
{
    return self.index - self.alert.firstOtherButtonIndex;
}

// Public
// is selected cancel button
- (BOOL)isCancel
{
    return (self.index == self.alert.cancelButtonIndex);
}

@end


////////////////////////////////////////////////////////////////////////////////
#pragma mark - FPAlert Class

@interface FPAlert () <UIAlertViewDelegate>
@property (nonatomic, copy) alert_block_t block;
@end

@implementation FPAlert
@synthesize block = _block;

#pragma mark - Life Cycle

// Public
// OK only
+ (FPAlert *)showOK:(NSString *)title
            message:(NSString *)message
{
    return [[self class] showOK:title
                        message:message
                     completion:nil];
}

// Public
// OK only + Blocks
+ (FPAlert *)showOK:(NSString *)title
            message:(NSString *)message
         completion:(alert_block_t)block
{
    return [[self class] show:title
                      message:message
                       cancel:@"OK"
                       others:nil
                   completion:block];
}

// Public
// Show Alert
+ (FPAlert *)show:(NSString *)title
          message:(NSString *)message
           cancel:(NSString *)cancel
           others:(NSArray *)others
       completion:(alert_block_t)block
{
    // |firstOtherButtonIndex| is not set
    // if |otherButtonTitles| array is |nil|.
    NSString *first = ([others count]) > 0 ? [others objectAtIndex:0] : nil;
    
    // instance
    FPAlert *alert = [[[self class] alloc] initWithTitle:title
                                                 message:message
                                                delegate:nil
                                       cancelButtonTitle:cancel
                                       otherButtonTitles:first, nil];
    alert.delegate = alert;
    alert.block    = block;
    
    // add other buttons
    for (NSString *other in others) {
        if (first != other) {
            [alert addButtonWithTitle:other];
        }
    }
    
    [alert show];
    
    return alert;
}

#pragma mark - UIAlertViewDelegate

// dismissed
- (void)alertView:(UIAlertView *)alertView
didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (self.block) {
        FPAlertResponse *res = [FPAlertResponse createWithAlert:alertView
                                                          index:buttonIndex];
        self.block(res);
    }
}

@end
