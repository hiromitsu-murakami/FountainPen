
#import <Foundation/Foundation.h>

////////////////////////////////////////////////////////////////////////////////
// Judgment Blank String

@interface NSString (Blank)

// YES : String length than 1
// NO  : Blank (or NSNull or nil)
- (BOOL)notBlank;

@end
