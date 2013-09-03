
#import "FPLocalInstanceVariables.h"


@implementation FPLocalInstanceVariablesSample

- (void)sample
{
    FPReadyLIVs;
    FPInitLIVs(count)   = @(1);
    FPInitLIVs(string)  = @"";
    FPInitLIVs(object)  = [[NSObject alloc] init];
    
    FPLIVs[string] = [NSString stringWithFormat:@"a %@", FPLIVs[count]];
    
    NSLog(@"    %@ %@  count %@  string %@  object 0x%x  FPLIVs 0x%x",
          self,
          self.name,
          FPLIVs[count],
          FPLIVs[string],
          (unsigned)FPLIVs[object],
          (unsigned)FPLIVs);
    
    //  NSLog(@"FPLIVs %@", FPLIVs);
    
    FPLIVs[count] = @([FPLIVs[count] integerValue] + 1);
}

- (void)sampleAlt
{
    FPReadyLIVs;
    FPInitLIVs(count)  = @(1);
    FPInitLIVs(string) = @"";
    FPInitLIVs(object) = [[NSObject alloc] init];
    
    FPLIVs[string] = [NSString stringWithFormat:@"a %@", FPLIVs[count]];
    
    NSLog(@"alt %@ %@  count %@  string %@  object 0x%x  FPLIVs 0x%x",
          self,
          self.name,
          FPLIVs[count],
          FPLIVs[string],
          (unsigned)FPLIVs[object],
          (unsigned)FPLIVs);
    
    //  NSLog(@"FPLIVs %@", FPLIVs);
    
    FPLIVs[count] = @([FPLIVs[count] integerValue] + 1);
}

@end
