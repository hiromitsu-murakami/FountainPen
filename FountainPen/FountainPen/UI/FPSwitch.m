
#import "FPSwitch.h"

#import "FPUtility.h"


@interface FPSwitch ()
@property (nonatomic, copy) FPSwitchBlock block;
@end

@implementation FPSwitch

#pragma mark - Life Cycle

// Create instance.
+ (instancetype)createWithFrame:(CGRect)frame
                          block:(FPSwitchBlock)block
{
    return [[self.class alloc] initWithFrame:frame
                                       block:block];
}

// Initialize.
- (instancetype)initWithFrame:(CGRect)frame
                        block:(FPSwitchBlock)block
{
    self = [super initWithFrame:frame];
    if (self) {
        self.block = block;
        
        [self addTarget:self
                 action:@selector(valueChanged)
       forControlEvents:UIControlEventValueChanged];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame
                         block:nil];
}


#pragma mark - Action

// Run block if value changed.
- (void)valueChanged
{
    FPB(self.block)(self);
}

@end
