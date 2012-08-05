
#import "FPString.h"

#pragma mark - string -> number

NSInteger Int   (NSString *string) { return [string integerValue]; }
CGFloat   Float (NSString *string) { return [string floatValue];   }
double    Double(NSString *string) { return [string doubleValue];  }

#pragma mark - number -> string

NSString *String(NSNumber *number) { return [number stringValue]; }
