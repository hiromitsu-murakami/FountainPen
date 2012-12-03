
#import "UIImage+More.h"

@implementation UIImage (Mask)

// マスク
// アルファ値を使う
- (UIImage *)mask:(UIImage *)mask
{
    CGImageRef composed = CGImageCreateWithMask(self.CGImage, mask.CGImage);
    UIImage *image = [UIImage imageWithCGImage:composed];
    CGImageRelease(composed);
    
    return image;
}

// マスク
// モノクロ画像を使う
- (UIImage *)maskMono:(UIImage *)mask
{
    CGImageRef mono = mask.CGImage;
    CGImageRef alpha = CGImageMaskCreate(CGImageGetWidth(mono),
                                         CGImageGetHeight(mono),
                                         CGImageGetBitsPerComponent(mono),
                                         CGImageGetBitsPerPixel(mono),
                                         CGImageGetBytesPerRow(mono),
                                         CGImageGetDataProvider(mono),
                                         NULL,
                                         false);
    CGImageRef composed = CGImageCreateWithMask(self.CGImage, alpha);
    UIImage *image = [UIImage imageWithCGImage:composed];
    
    CGImageRelease(composed);
    CGImageRelease(alpha);
    
    return image;
}

// シルエットにあわせて暗くする
// （UIButtonをタップしているときのような感じ）
- (UIImage *)darken:(CGFloat)darker
{
    UIImage *black    = [self silhouette];
    UIImage *half     = [black alpha:darker];
    UIImage *multiply = [self multiply:half];
    return multiply;
}

// グレイスケール
- (UIImage *)grayscale
{
    UIImage *gray   = [self noAlphaGrayscale];
    UIImage *mask   = [self silhouette];
    UIImage *masked = [gray mask:mask];
    return masked;
}

// グレイスケール（アルファなし）
- (UIImage *)noAlphaGrayscale
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate(nil,
                                                 self.size.width,
                                                 self.size.height,
                                                 8,
                                                 0,
                                                 colorSpace,
                                                 kCGImageAlphaNone);
    
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextDrawImage(context, rect, self.CGImage);
    CGImageRef cgimage = CGBitmapContextCreateImage(context);
    UIImage *image = [UIImage imageWithCGImage:cgimage];
    
    CGImageRelease(cgimage);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    return image;
}

// シルエット
// アルファ値だけの画像
// マスクなどに使える
- (UIImage *)silhouette
{
    CGContextRef context = CGBitmapContextCreate(nil,
                                                 self.size.width,
                                                 self.size.height,
                                                 8,
                                                 0,
                                                 nil,
                                                 kCGImageAlphaOnly);
    
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextDrawImage(context, rect, self.CGImage);
    CGImageRef cgimage = CGBitmapContextCreateImage(context);
    UIImage *image = [UIImage imageWithCGImage:cgimage];
    
    CGImageRelease(cgimage);
    CGContextRelease(context);
    
    return image;
}

// 画像を半透明にする
- (UIImage *)alpha:(CGFloat)alpha
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextScaleCTM(context, 1, -1);
    CGContextTranslateCTM(context, 0, -rect.size.height);
    CGContextSetBlendMode(context, kCGBlendModeMultiply);
    CGContextSetAlpha(context, alpha);
    CGContextDrawImage(context, rect, self.CGImage);
    
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return result;
}

// 乗算合成
- (UIImage *)multiply:(UIImage *)blend
{
    return [self blend:blend mode:kCGBlendModeMultiply];
}

// 合成
- (UIImage *)blend:(UIImage *)blend
              mode:(CGBlendMode)mode
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    [self drawInRect:rect];
    [blend drawInRect:rect blendMode:mode alpha:1.0];
    
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return result;
}

@end
