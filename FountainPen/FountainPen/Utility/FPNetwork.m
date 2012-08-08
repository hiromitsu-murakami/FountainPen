
#import "FPNetwork.h"

#if ! __has_feature(objc_arc)
#error Need "ARC" to project or "-fobjc-arc" flag to file.
#endif

////////////////////////////////////////////////////////////////////////////////
#pragma mark - FPNetworkResponse Class

@interface FPNetworkResponse ()
@property (nonatomic, strong) NSData  *data;
@property (nonatomic, strong) NSError *error;
@end

@implementation FPNetworkResponse

+ (id)createWithData:(NSData *)data
               error:(NSError *)error
{
    return [[[self class] alloc] initWithData:data
                                        error:error];
}

- (id)initWithData:(NSData *)data
             error:(NSError *)error
{
    self = [super init];
    if (self) {
        self.data  = data;
        self.error = error;
    }
    return self;
}

@end

////////////////////////////////////////////////////////////////////////////////
#pragma mark - FPNetwork Class

@implementation FPNetwork

// Load URL (iOS 5.0 and later)
+ (void)load:(NSString *)url
  completion:(load_block_t)block
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[[NSOperationQueue alloc] init]
                           completionHandler:^(NSURLResponse *response,
                                               NSData        *data,
                                               NSError       *error) {
                               if (block) {
                                   block([FPNetworkResponse createWithData:data
                                                                     error:error]);
                               }
                           }];
}

@end
