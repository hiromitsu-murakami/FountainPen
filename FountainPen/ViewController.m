
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
           others:@[@"A", @"B"]
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
           others:@[@"A", @"B"]
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
    NSInteger i = Int(@"1");
    CGFloat   f = Float(@"1.234");
    double    d = Double(@"2.345");
    
    fp(@"int     %d", i);
    fp(@"float   %g", f);
    fp(@"ddouble %g", d);
    
    NSString *is = String(@(2));
    NSString *fs = String(@(3.456f));
    NSString *ds = String(@(4.567));
    
    fp(@"string %@", is);
    fp(@"string %@", fs);
    fp(@"string %@", ds);
}

- (IBAction)touchedNetworkButton:(id)sender
{
    [FPNetwork load:@"http://google.com"
         completion:^(FPNetworkResponse *res) {
             if (res.error) {
                 p(@"error %@", res.error);
             }
             
             p(@"data %d", [res.data length]);
         }];
}

@end
