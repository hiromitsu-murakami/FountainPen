
#import <Foundation/Foundation.h>

//#define FPOnce(block) static dispatch_once_t FPOnceToken; dispatch_once(&FPOnceToken, block)

////////////////////////////////////////////////////////////////////////////////
// Multi Thread
//
@interface FPThread : NSObject

// Run block after delay in secconds
+ (void)delay:(double)delay
   completion:(void (^)(void))block;

+ (void)main:(void (^)(void))block;
+ (void)global:(void (^)(void))block;

//+ (void)once:(dispatch_once_t *)onceToken
//  completion:(void (^)(void))block;
@end
