
#import "FPString.h"

#pragma mark - string -> number

NSInteger IfS(NSString *string) { return IfromS(string); }
float     FfS(NSString *string) { return FfromS(string); }
double    DfS(NSString *string) { return DfromS(string); }

NSInteger IfromS(NSString *string) { return [string integerValue]; }
float     FfromS(NSString *string) { return [string floatValue];   }
double    DfromS(NSString *string) { return [string doubleValue];  }

#pragma mark - number -> string

NSString *SfI(NSInteger number) { return SfromI(number); }
NSString *SfF(float     number) { return SfromF(number); }
NSString *SfD(double    number) { return SfromD(number); }

NSString *SfromI(NSInteger number) { return [NSString stringWithFormat:@"%d", number]; }
NSString *SfromF(float     number) { return [NSString stringWithFormat:@"%g", number]; }
NSString *SfromD(double    number) { return [NSString stringWithFormat:@"%g", number]; }
