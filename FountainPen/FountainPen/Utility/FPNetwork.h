
#import <Foundation/Foundation.h>

////////////////////////////////////////////////////////////////////////////////
// Response
//
@interface FPNetworkResponse : NSObject
@property (nonatomic, strong, readonly) NSData  *data;
@property (nonatomic, strong, readonly) NSError *error;
@end

////////////////////////////////////////////////////////////////////////////////
// Blocks type for Loader
//
typedef void (^load_block_t)(FPNetworkResponse *res);

////////////////////////////////////////////////////////////////////////////////
// HTTP Loader
//
@interface FPNetwork : NSObject

+ (void)load:(NSString *)url
  completion:(load_block_t)block;

@end
