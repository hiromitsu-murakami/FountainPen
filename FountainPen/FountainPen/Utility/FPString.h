
#import <Foundation/Foundation.h>

// string -> number
NSInteger IfS(NSString *string);
float     FfS(NSString *string);
double    DfS(NSString *string);

NSInteger IfromS(NSString *string);
float     FfromS(NSString *string);
double    DfromS(NSString *string);

// number -> string
NSString *SfI(NSInteger number);
NSString *SfF(float     number);
NSString *SfD(double    number);

NSString *SfromI(NSInteger number);
NSString *SfromF(float     number);
NSString *SfromD(double    number);
