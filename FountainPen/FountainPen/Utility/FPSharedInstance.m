
#import "FPSharedInstance.h"

#if ! __has_feature(objc_arc)
#error Need "ARC" to project or "-fobjc-arc" flag to file.
#endif

@implementation FPSharedInstance

// Convenience
+ (id)sharedInstance
{
    // Dictionary of SubClass's instance
    static NSMutableDictionary *subs = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        subs = [NSMutableDictionary dictionary];
    });
    
    // Exclusion by SubClass's class object
    @synchronized([self class]) {
        NSString *key = NSStringFromClass([self class]);
        id sub = [subs objectForKey:key];
        if (!sub) {
            sub = [[[self class] alloc] init];
            [subs setObject:sub forKey:key];
        }
        return sub;
    }
}

@end
