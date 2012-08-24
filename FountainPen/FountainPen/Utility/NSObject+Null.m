
#import "NSObject+Null.h"

@implementation NSObject (Null)

- (BOOL)notNull
{
    return (self != [NSNull null]);
}

@end
