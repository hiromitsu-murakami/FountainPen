
#import "FPNilBlocksPattern.h"

// Sample
typedef void (^FPVoidBlocks)(void);
typedef void (^FPArgBlocks)(BOOL success);
typedef BOOL (^FPReturnBlocks)(void);
typedef BOOL (^FPBothBlocks)(BOOL success);
typedef id   (^FPObjectBlocks)(id obj);
typedef id   (^FPTwoBlocks)(id obj, BOOL success);


// Sample
@implementation FPNilBlocksPattern

+ (void)runBlocks
{
    // Void
    {
        FPVoidBlocks block = ^{
            NSLog(@"Void run");
        };
        
        FPB(block)();
        
        // nil
        block = nil;
        
        FPB(block)();
    }
    
    // Arg
    {
        FPArgBlocks block = ^(BOOL success) {
            NSLog(@"Arg run %d", success);
        };
        
        FPB(block)(YES);
        
        // nil
        block = nil;
        
        FPB(block)(YES);
    }
    
    // Return
    {
        FPReturnBlocks block = ^{
            NSLog(@"Return run");
            return YES;
        };
        
        BOOL rt1 = FPB(block)();
        
        NSLog(@"Return return1 %d", rt1);
        NSAssert(rt1 == YES, @"Return Error");
        
        // nil
        block = nil;
        
        BOOL rt2 = FPB(block)();
        
        NSLog(@"Return return2 %d", rt2);
        NSAssert(rt2 != YES, @"Return Error");
    }
    
    // Both
    {
        FPBothBlocks block = ^(BOOL success) {
            NSLog(@"Both run %d", success);
            return YES;
        };
        
        BOOL b1 = FPB(block)(YES);
        
        NSLog(@"Both return1 %d", b1);
        NSAssert(b1 == YES, @"Both Error");
        
        // nil
        block = nil;
        
        BOOL b2 = FPB(block)(YES);
        
        NSLog(@"Both return2 %d", b2);
        NSAssert(b2 != YES, @"Both Error");
    }
    
    // Object
    {
        FPObjectBlocks block = ^(id obj) {
            NSLog(@"Run Object run %@", obj);
            return @"ReturnObject";
        };
        
        id o1 = FPB(block)(@"arg1");
        
        NSLog(@"Object return1 %@", o1);
        NSAssert(o1 != nil, @"Object Error");
        
        // nil
        block = nil;
        
        id o2 = FPB(block)(@"arg2");
        
        NSLog(@"Object return2 %@", o2);
        NSAssert(o2 == nil, @"Object Error");
    }
    
    // Two
    {
        FPTwoBlocks block = ^(id obj, BOOL success) {
            NSLog(@"Two run %@ %d", obj, success);
            return @"ReturnObject";
        };
        
        id o1 = FPB(block)(@"arg1", YES);
        
        NSLog(@"Two return1 %@", o1);
        NSAssert(o1 != nil, @"Two Error");
        
        // nil
        block = nil;
        
        id o2 = FPB(block)(@"arg2", YES);
        
        NSLog(@"Two return2 %@", o2);
        NSAssert(o2 == nil, @"Two Error");
    }
    
    // Direct
    {
        FPB(^{
            NSLog(@"Direct run");
        })();
    }
    
    // Nil
    {
        FPB((FPVoidBlocks)nil)();
    }
    
    // OtherMethod
    {
        [[self class] otherMethod:^id(id obj, BOOL success) {
            NSLog(@"OtherMethod run %@ %d", obj, success);
            return @"ReturnObject";
        }];
        
        [[self class] otherMethod:nil];
    }
    
    // BUG
    {
        FPVoidBlocks block = ^{
            NSLog(@"Void run");
        };
        
        // forget "()".
        
        FPB(block)();               // OK
        
//        FPB(block);                 // warning: expression result unused
        
//        BOOL b = FPB(block);     // error: expression of incompatible type
        
        NSString *str = FPB(block); // no error. no warning. but this is BUG.
        NSLog(@"BUG %@", str);      // BUG <__NSGlobalBlock__: 0xABC>
        
        NSString *str2 = block;     // Why?
        NSLog(@"BUG %@", str2);
    }
}

+ (void)otherMethod:(FPTwoBlocks)block
{
    double delayInSeconds = 0.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        id o1 = FPB(block)(@"arg1", YES);
        
        NSLog(@"OtherMethod return %@", o1);
        
        if (block) {
            NSAssert(o1 != nil, @"OtherMethod Error");
        } else {
            NSAssert(o1 == nil, @"OtherMethod Error");
        }
    });
}

@end

