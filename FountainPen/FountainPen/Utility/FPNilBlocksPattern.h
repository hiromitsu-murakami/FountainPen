
#import <Foundation/Foundation.h>


// return 0 if nil Blocks. (like nil NSObject)
// ex. KLMB(block)();               // OK
//     KLMB(block);                 // NG
//     NSString *str = KLMB(block); // NG (no warning)
#define FPBlocks(block)    !(block) ? 0 : (block)
#define FPB(block)         FPBlocks(block)


// Sample
@interface FPNilBlocksPattern : NSObject
+ (void)runBlocks;
@end
