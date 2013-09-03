
#import "NSObject+Convenience.h"

@implementation NSObject (Convenience)

// Convenience
+ (instancetype)create
{
#if __has_feature(objc_arc)
    return [[[self class] alloc] init]; // ARC
#else
    return [[[self class] alloc] init] autorelease];
#endif
}

@end
