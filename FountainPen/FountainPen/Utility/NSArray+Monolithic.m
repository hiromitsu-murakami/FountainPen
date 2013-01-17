
#import "NSArray+Monolithic.h"


@interface FPMonolithicArray : NSArray
@end

@interface FPMonolithicMutableArray : NSMutableArray
@property (nonatomic, retain) Class genericsType;
@end

//////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - NSArray

@implementation NSArray (Monolithic)

+ (id)arrayWithClass:(Class)genericsType
           withArray:(NSArray *)array
{
    return [[FPMonolithicArray class] arrayWithClass:genericsType
                                           withArray:array];
}

- (Class)genericsType
{
    return [NSObject class];
}

@end


//////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - NSMutableArray

@implementation NSMutableArray (Monolithic)


+ (id)arrayWithClass:(Class)genericsType
{
    return [[FPMonolithicMutableArray class] arrayWithClass:genericsType];
}

+ (id)arrayWithClass:(Class)genericsType
           withArray:(NSArray *)array
{
    return [[FPMonolithicMutableArray class] arrayWithClass:genericsType
                                                  withArray:array];
}

@end


//////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - GenericsArray

@interface FPMonolithicArray ()
@property (nonatomic, retain) FPMonolithicMutableArray *internal;
@end

@implementation FPMonolithicArray

+ (id)arrayWithClass:(Class)genericsType
           withArray:(NSArray *)array
{
#if __has_feature(objc_arc)
    return [[[self class] alloc] initWithClass:genericsType
                                     withArray:array];
#else
    return [[[[self class] alloc] initWithClass:genericsType
                                      withArray:array] autorelease];
#endif
}

- (id)initWithClass:(Class)genericsType
          withArray:(NSArray *)array
{
    self = [super init];
    if (self) {
        self.internal = [FPMonolithicMutableArray arrayWithClass:genericsType
                                                       withArray:array];
    }
    return self;
}

#pragma mark - NSArray must override methods

// Any subclass of NSArray must override the primitive instance methods
//  count
//  objectAtIndex:

- (NSUInteger)count                   { return self.internal.count; }
- (id)objectAtIndex:(NSUInteger)index { return [self.internal objectAtIndex:index]; }

#pragma mark -

- (Class)genericsType
{
    return self.internal.genericsType;
}

@end


//////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - GenericsMutableArray

@interface FPMonolithicMutableArray ()
@property (nonatomic, retain) NSMutableArray *internal;
@end

@implementation FPMonolithicMutableArray

+ (id)arrayWithClass:(Class)genericsType
{
    return [[self class] arrayWithClass:genericsType
                              withArray:nil];
}

+ (id)arrayWithClass:(Class)genericsType
           withArray:(NSArray *)array
{
#if __has_feature(objc_arc)
    return [[[self class] alloc] initWithClass:genericsType
                                     withArray:array];
#else
    return [[[[self class] alloc] initWithClass:genericsType
                                      withArray:array] autorelease];
#endif
}

- (id)initWithClass:(Class)genericsType
          withArray:(NSArray *)array
{
    self = [super init];
    if (self) {
        self.genericsType = genericsType;
        self.internal = [NSMutableArray array];
        
        for (id anObject in array) {
            [self addObject:anObject];
        }
    }
    return self;
}

#pragma mark - NSArray must override methods

// Any subclass of NSArray must override the primitive instance methods
//  count
//  objectAtIndex:

- (NSUInteger)count                   { return self.internal.count; }
- (id)objectAtIndex:(NSUInteger)index { return [self.internal objectAtIndex:index]; }

#pragma mark - NSMutableArray must override methods

// Any subclass of NSMutableArray must override the primitive instance methods
//  insertObject:atIndex:
//  removeObjectAtIndex:
//  addObject:
//  removeLastObject
//  replaceObjectAtIndex:withObject:

- (void)addObject:(id)anObject
{
    if ([self invalidObject:anObject]) {
        return;
    }
    
    [self.internal addObject:anObject];
}

- (void)insertObject:(id)anObject atIndex:(NSUInteger)index
{
    if ([self invalidObject:anObject]) {
        return;
    }
    
    [self.internal insertObject:anObject atIndex:index];
}

- (void)removeObjectAtIndex:(NSUInteger)index
{
    [self.internal removeObjectAtIndex:index];
}

- (void)removeLastObject
{
    [self.internal removeLastObject];
}

- (void)replaceObjectAtIndex:(NSUInteger)index
                  withObject:(id)anObject
{
    if ([self invalidObject:anObject]) {
        return;
    }
    
    [self.internal replaceObjectAtIndex:index
                             withObject:anObject];
}

#pragma mark - NSMutableArray override methods

- (void)addObjectsFromArray:(NSArray *)otherArray
{
    for (id anObject in otherArray) {
        [self addObject:anObject];
    }
}

- (void)setArray:(NSArray *)otherArray
{
    [self removeAllObjects];
    [self addObjectsFromArray:otherArray];
}

//- (void)addObjectsFromArray:(NSArray *)otherArray;
//- (void)exchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2;
//- (void)removeAllObjects;
//- (void)removeObject:(id)anObject inRange:(NSRange)range;
//- (void)removeObject:(id)anObject;
//- (void)removeObjectIdenticalTo:(id)anObject inRange:(NSRange)range;
//- (void)removeObjectIdenticalTo:(id)anObject;
//- (void)removeObjectsFromIndices:(NSUInteger *)indices numIndices:(NSUInteger)cnt NS_DEPRECATED(10_0, 10_6, 2_0, 4_0);
//- (void)removeObjectsInArray:(NSArray *)otherArray;
//- (void)removeObjectsInRange:(NSRange)range;
//- (void)replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray *)otherArray range:(NSRange)otherRange;
//- (void)replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray *)otherArray;
//- (void)setArray:(NSArray *)otherArray;
//- (void)sortUsingFunction:(NSInteger (*)(id, id, void *))compare context:(void *)context;
//- (void)sortUsingSelector:(SEL)comparator;
//
//- (void)insertObjects:(NSArray *)objects atIndexes:(NSIndexSet *)indexes;
//- (void)removeObjectsAtIndexes:(NSIndexSet *)indexes;
//- (void)replaceObjectsAtIndexes:(NSIndexSet *)indexes withObjects:(NSArray *)objects;
//
//- (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)idx NS_AVAILABLE(10_8, 6_0);
//
//#if NS_BLOCKS_AVAILABLE
//- (void)sortUsingComparator:(NSComparator)cmptr NS_AVAILABLE(10_6, 4_0);
//- (void)sortWithOptions:(NSSortOptions)opts usingComparator:(NSComparator)cmptr NS_AVAILABLE(10_6, 4_0);

#pragma mark -

- (BOOL)invalidObject:(id)anObject
{
    return [anObject isKindOfClass:self.genericsType] ? NO : YES;
}

@end

