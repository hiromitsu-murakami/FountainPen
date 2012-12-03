
#import <Foundation/Foundation.h>

@interface UIImage (Mask)
- (UIImage *)mask:(UIImage *)mask;
- (UIImage *)maskMono:(UIImage *)mask;

- (UIImage *)darken:(CGFloat)darker;
- (UIImage *)grayscale;

- (UIImage *)silhouette;
- (UIImage *)alpha:(CGFloat)alpha;

- (UIImage *)multiply:(UIImage *)blend;
- (UIImage *)blend:(UIImage *)blend mode:(CGBlendMode)mode;
@end
