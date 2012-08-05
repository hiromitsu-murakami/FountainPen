
#import "NSObject+Convenience.h"

#if ! __has_feature(objc_arc)
#error Need "ARC" to project or "-fobjc-arc" flag to file.
#endif

@implementation NSObject (Convenience)

+ (id)create
{
    return [[[self class] alloc] init];
}

@end
