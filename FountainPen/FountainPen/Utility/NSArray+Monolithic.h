
#import <Foundation/Foundation.h>

@interface NSArray (Monolithic)

- (Class)genericsType;

+ (id)arrayWithClass:(Class)genericsType
           withArray:(NSArray *)array;
@end

@interface NSMutableArray (Monolithic)

+ (id)arrayWithClass:(Class)genericsType;
+ (id)arrayWithClass:(Class)genericsType
           withArray:(NSArray *)array;

@end

