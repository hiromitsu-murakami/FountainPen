
#import <Foundation/Foundation.h>

void       p (NSString *format, ...);
void       pv(NSString *format, va_list args);
NSString *sp (NSString *format, ...);
NSString *spv(NSString *format, va_list args);

#ifdef DEBUG
#   define f()     p(@"%s line:%d",    __PRETTY_FUNCTION__, __LINE__)
#   define fp(...) p(@"%s line:%d %@", __PRETTY_FUNCTION__, __LINE__, sp(__VA_ARGS__))
#else
#   define f()     ;
#   define fp(...) ;
#endif