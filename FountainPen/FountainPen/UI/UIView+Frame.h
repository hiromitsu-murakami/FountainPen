
#import <UIKit/UIKit.h>

////////////////////////////////////////////////////////////////////////////////
// Shortcut of frame rect

@interface UIView (Frame)

@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;
@property (nonatomic) CGFloat w;
@property (nonatomic) CGFloat h;

// Origin
- (void)x:(CGFloat)x
        y:(CGFloat)y;

// Size
- (void)w:(CGFloat)w
        h:(CGFloat)h;

// Frame
- (void)x:(CGFloat)x
        y:(CGFloat)y
        w:(CGFloat)w
        h:(CGFloat)h;
@end
