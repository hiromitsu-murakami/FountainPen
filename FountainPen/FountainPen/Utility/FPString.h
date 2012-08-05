
#import <Foundation/Foundation.h>

////////////////////////////////////////////////////////////////////////////////
// Number/String Converter

// String -> Number
NSInteger Int   (NSString *string);
CGFloat   Float (NSString *string);
double    Double(NSString *string);

// Number -> String
// ex. String(@(value));
NSString *String(NSNumber *number);
