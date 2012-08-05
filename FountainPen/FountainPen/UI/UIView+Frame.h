
#import <UIKit/UIKit.h>

////////////////////////////////////////////////////////////////////////////////
// Shortcut of frame rect

@interface UIView (Frame)

@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;
@property (nonatomic) CGFloat w;
@property (nonatomic) CGFloat h;

- (void)x:(CGFloat)x
        y:(CGFloat)y;

- (void)w:(CGFloat)w
        h:(CGFloat)h;

- (void)x:(CGFloat)x
        y:(CGFloat)y
        w:(CGFloat)w
        h:(CGFloat)h;
@end
