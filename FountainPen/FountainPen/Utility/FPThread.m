
#import "FPThread.h"

@implementation FPThread

// Run block after delay in secconds
+ (void)delay:(double)delay
   completion:(void (^)(void))block
{
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC);
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_after(popTime, queue, block);
}

// Run block on Main thread
+ (void)main:(void (^)(void))block
{
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_async(queue, block);
}

// Run block on Global queue
+ (void)global:(void (^)(void))block
{
    dispatch_queue_t queue = global_queue();
    dispatch_async(queue, block);
}

dispatch_queue_t global_queue()
{
    return dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
}

//// Run Once
//+ (void)once:(dispatch_once_t *)onceToken
//  completion:(void (^)(void))block
//{
//    dispatch_once(onceToken, block);
//}

@end
