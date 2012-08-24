
#import "FPURL.h"

@implementation FPURL

+ (BOOL)open:(NSString *)url
{
    return [[self class] openURL:[NSURL URLWithString:url]];
}

+ (BOOL)openURL:(NSURL *)url
{
    UIApplication *app = [UIApplication sharedApplication];
    return [app openURL:url];
}

+ (BOOL)canOpen:(NSString *)url
{
    return [[self class] canOpenURL:[NSURL URLWithString:url]];
}

+ (BOOL)canOpenURL:(NSURL *)url
{
    UIApplication *app = [UIApplication sharedApplication];
    return [app canOpenURL:url];
}

@end
