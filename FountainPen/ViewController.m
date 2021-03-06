
#import "ViewController.h"

#import "FountainPen.h"

@interface ShObj : FPSharedInstance
@end
@implementation ShObj
@end

@interface ViewController ()
@end

@implementation ViewController

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)viewDidLoad
{
    // FPSharedInstance
    ShObj *so = [ShObj sharedInstance];
    p(@"ShObj %@", so);
    
    [self localInstanceVariables];
}

// FPLocalInstanceVariables
- (void)localInstanceVariables
{
    FPLocalInstanceVariablesSample *liv1 = [FPLocalInstanceVariablesSample create];
    FPLocalInstanceVariablesSample *liv2 = [FPLocalInstanceVariablesSample create];
    FPLocalInstanceVariablesSample *liv3 = [FPLocalInstanceVariablesSample create];
    
    liv1.name = @"liv1";
    liv2.name = @"liv2";
    liv3.name = @"liv3";
    
    p(@"1\n");
    [liv1 sample];
    p(@"1\n");
    [liv1 sampleAlt];
    p(@"1,2\n");
    [liv2 sample];
    [liv2 sample];
    p(@"1\n");
    [liv2 sampleAlt];
    p(@"1,2,3\n");
    [liv3 sample];
    [liv3 sample];
    [liv3 sample];
    p(@"1\n");
    [liv3 sampleAlt];
    
    p(@"2\n");
    [liv1 sample];
    p(@"2\n");
    [liv1 sampleAlt];
    p(@"3,4\n");
    [liv2 sample];
    [liv2 sample];
    p(@"2\n");
    [liv2 sampleAlt];
    p(@"4,5,6\n");
    [liv3 sample];
    [liv3 sample];
    [liv3 sample];
    p(@"2\n");
    [liv3 sampleAlt];
}

// Alert Button
- (IBAction)touchedAlertButton:(id)sender
{
    [FPAlert show:L10n(@"FPTitle")
          message:L10n(@"FPMessage")
           cancel:L10n(@"FPCancel")
           others:@[@"A", @"B"]
       completion:^(FPAlert *alert) {
           p(@"alert index %d", alert.index);
           
           if (alert.isCancel) {
               p(@"alert cancel");
               return;
           }
           
           switch (alert.indexInOthers) {
               case 0:  { p(@"alert others A"); break; }
               case 1:  { p(@"alert others B"); break; }
               default: { p(@"alert default");  break; }
           }
       }];
}

// Sheet Button
- (IBAction)touchedSheetButton:(id)sender
{
    [FPSheet show:L10n(@"FPTitle")
           cancel:L10n(@"FPCancel")
      destructive:L10n(@"FPDestructive")
           others:@[@"A", @"B"]
       completion:^(FPSheet *sheet) {
           p(@"sheet index %d", sheet.index);
           
           if (sheet.isCancel) {
               p(@"sheet cancel");
               return;
           }
           if (sheet.isDestructive) {
               p(@"sheet destructive");
               return;
           }
           
           switch (sheet.indexInOthers) {
               case 0:  { p(@"sheet others A"); break; }
               case 1:  { p(@"sheet others B"); break; }
               default: { p(@"sheet default");  break; }
           }
       }];
}

// Number Button
- (IBAction)touchedNumberButton:(id)sender
{
    NSInteger i = Int(@"1");
    CGFloat   f = Float(@"1.234");
    double    d = Double(@"2.345");
    
    p(@"int     %d", i);
    p(@"float   %g", f);
    p(@"ddouble %g", d);
    
    NSString *is = String(@(2));
    NSString *fs = String(@(3.456f));
    NSString *ds = String(@(4.567));
    
    p(@"string %@", is);
    p(@"string %@", fs);
    p(@"string %@", ds);
}

- (IBAction)touchedNetworkButton:(UIButton *)sender
{
    sender.enabled = NO;
    [FPNetwork load:@"http://google.com"
         completion:^(FPNetworkResponse *res) {
             sender.enabled = YES;
             if (res.error) {
                 p(@"error %@", res.error);
             }
             
             p(@"data %d", [res.data length]);
         }];
}

@end
