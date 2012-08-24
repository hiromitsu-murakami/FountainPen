
#import "NSString+Blank.h"

@implementation NSString (Blank)

- (BOOL)notBlank
{
    if (!self) {
        return NO;
    }
    if ([self length] < 1) {
        return NO;
    }
    
    return YES;
}

@end
