
#import "UIView+Frame.h"

@implementation UIView (Frame)

- (CGFloat)x { return self.frame.origin.x;    }
- (CGFloat)y { return self.frame.origin.y;    }
- (CGFloat)w { return self.frame.size.width;  }
- (CGFloat)h { return self.frame.size.height; }

- (void)setX:(CGFloat)x { [self x:x      y:self.y]; }
- (void)setY:(CGFloat)y { [self x:self.x y:y     ]; }
- (void)setW:(CGFloat)w { [self w:w      h:self.h]; }
- (void)setH:(CGFloat)h { [self w:self.w h:h     ]; }

- (void)x:(CGFloat)x y:(CGFloat)y
{
    [self x:x y:y w:self.w h:self.h];
}

- (void)w:(CGFloat)w h:(CGFloat)h
{
    [self x:self.x y:self.y w:w h:h];
}

- (void)x:(CGFloat)x y:(CGFloat)y w:(CGFloat)w h:(CGFloat)h
{
    self.frame = CGRectMake(x, y, w, h);
}

@end
