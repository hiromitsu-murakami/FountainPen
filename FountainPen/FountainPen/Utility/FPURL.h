
#import <Foundation/Foundation.h>

@interface FPURL : NSObject

+ (BOOL)open:(NSString *)url;
+ (BOOL)openURL:(NSURL *)url;
+ (BOOL)canOpen:(NSString *)url;
+ (BOOL)canOpenURL:(NSURL *)url;

@end
