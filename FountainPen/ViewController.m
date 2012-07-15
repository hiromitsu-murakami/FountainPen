
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

// Alert Button
- (IBAction)touchedAlertButton:(id)sender
{
    ShObj *so = [ShObj sharedInstance];
    fp(@"ShObj %@", so);
    
    [FPAlert show:L10n(@"Title")
          message:L10n(@"Message")
           cancel:L10n(@"Cancel")
           others:[NSArray arrayWithObjects:@"A", @"B", nil]
       completion:^(FPAlertResponse *alert) {
           fp(@"alert index %d", alert.index);
           
           if (alert.isCancel) {
               fp(@"alert cancel");
               return;
           }
           
           switch (alert.indexInOthers) {
               case 0:  { fp(@"alert others A"); break; }
               case 1:  { fp(@"alert others B"); break; }
               default: { fp(@"alert default");  break; }
           }
       }];
}

// Sheet Button
- (IBAction)touchedSheetButton:(id)sender
{
    ShObj *so = [ShObj sharedInstance];
    fp(@"ShObj %@", so);
    
    [FPSheet show:L10n(@"Title")
           cancel:L10n(@"Cancel")
      destructive:L10n(@"Destructive")
           others:[NSArray arrayWithObjects:@"A", @"B", nil]
       completion:^(FPSheetResponse *sheet) {
           fp(@"sheet index %d", sheet.index);
           
           if (sheet.isCancel) {
               fp(@"sheet cancel");
               return;
           }
           if (sheet.isDestructive) {
               fp(@"sheet destructive");
               return;
           }
           
           switch (sheet.indexInOthers) {
               case 0:  { fp(@"sheet others A"); break; }
               case 1:  { fp(@"sheet others B"); break; }
               default: { fp(@"sheet default");  break; }
           }
       }];
}

// Number Button
- (IBAction)touchedNumberButton:(id)sender
{
    NSInteger i = IfS(@"1");
    float     f = FfS(@"1.234");
    double    d = DfS(@"2.345");
    
    fp(@"i %d", i);
    fp(@"f %g", f);
    fp(@"d %g", d);
    
    NSString *is = SfI(2);
    NSString *fs = SfF(3.456f);
    NSString *ds = SfD(4.567);
    
    fp(@"is %@", is);
    fp(@"fs %@", fs);
    fp(@"ds %@", ds);
}
@end
