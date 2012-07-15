
#import "FPLog.h"

void p(NSString *format, ...)
{
    va_list args;
    va_start(args, format);
    pv(format, args);
    va_end(args);
}

void pv(NSString *format, va_list args)
{
    NSLogv(format, args);
}

NSString *sp(NSString *format, ...)
{
    va_list args;
    va_start(args, format);
    NSString *str = spv(format, args);
    va_end(args);
    return str;
}

NSString *spv(NSString *format, va_list args)
{
#if __has_feature(objc_arc)
    return [[NSString alloc] initWithFormat:format arguments:args]; // ARC
#else
    return [[[NSString alloc] initWithFormat:format arguments:args] autorelease];
#endif
}
