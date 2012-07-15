
#import "FPSheet.h"

////////////////////////////////////////////////////////////////////////////////
#pragma mark - MKAlertResponse Class

@interface FPSheetResponse ()
@property (readwrite, nonatomic, strong) UIActionSheet *sheet;
@property (readwrite, nonatomic)         NSInteger     index;
@property (readwrite, nonatomic)         BOOL          isCancel;
@property (readwrite, nonatomic)         BOOL          isDestructive;
@end

@implementation FPSheetResponse
@synthesize sheet = _sheet;
@synthesize index = _index;
@dynamic    isCancel;
@dynamic    isDestructive;

// Convenience
+ (FPSheetResponse *)createWithSheet:(UIActionSheet *)sheet
                               index:(NSInteger)index
{
    return [[[self class] alloc] initWithSheet:sheet index:index];
}

// initial
- (id)initWithSheet:(UIActionSheet *)sheet
              index:(NSInteger)index
{
    self = [super init];
    if (self) {
        self.sheet = sheet;
        self.index = index;
    }
    return self;
}

// Public
// is selected cancel button
- (BOOL)isCancel
{
    return (self.index == self.sheet.cancelButtonIndex);
}

// Public
// is selected destructive button
- (BOOL)isDestructive
{
    return (self.index == self.sheet.destructiveButtonIndex);
}

@end


////////////////////////////////////////////////////////////////////////////////
#pragma mark - MKSheet Class

@interface FPSheet () <UIActionSheetDelegate>
@property (nonatomic, copy) sheet_block_t block;
@end

@implementation FPSheet
@synthesize block = _block;

#pragma mark - Life Cycle

// Public
// Show Sheet
+ (FPSheet *)show:(NSString *)title
           cancel:(NSString *)cancel
      destructive:(NSString *)destructive
           others:(NSArray *)others
       completion:(sheet_block_t)block
{
    // |firstOtherButtonIndex| is not set
    // if |otherButtonTitles| array is |nil|.
    NSString *first = ([others count]) > 0 ? [others objectAtIndex:0] : nil;
    
    // instance
    FPSheet *sheet = [[[self class] alloc] initWithTitle:title
                                                 delegate:nil
                                        cancelButtonTitle:nil
                                   destructiveButtonTitle:destructive
                                        otherButtonTitles:first, nil];
    sheet.delegate = sheet;
    sheet.block    = block;
    
    // add other buttons
    for (NSString *other in others) {
        if (first != other) {
            [sheet addButtonWithTitle:other];
        }
    }
    
    // Cancel button must be added to the end.
    if (cancel) {
        [sheet addButtonWithTitle:cancel];
        sheet.cancelButtonIndex = (destructive ? 1 : 0) + [others count];
    }
    
    [sheet showInView:[UIApplication sharedApplication].keyWindow];
    return sheet;
}

#pragma mark - UIActionSheetDelegate

// Dismissed
- (void)actionSheet:(UIActionSheet *)actionSheet
didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (self.block) {
        FPSheetResponse *res = [FPSheetResponse createWithSheet:actionSheet
                                                          index:buttonIndex];
        self.block(res);
    }
}

@end
