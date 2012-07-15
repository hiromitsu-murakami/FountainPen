
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
           if (alert.isCancel) {
               fp(@"alert cancel");
               return;
           }
           
           switch (alert.indexInOthers) {
               case 0:
                   fp(@"alert others A");
                   break;
               case 1:
                   fp(@"alert others B");
                   break;
               default:
                   fp(@"alert default");
                   break;
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
           if (sheet.isCancel) {
               fp(@"sheet cancel");
               return;
           }
           if (sheet.isDestructive) {
               fp(@"sheet destructive");
               return;
           }
           
           switch (sheet.indexInOthers) {
               case 0:
                   fp(@"sheet others A");
                   break;
               case 1:
                   fp(@"sheet others B");
                   break;
               default:
                   fp(@"sheet default");
                   break;
           }
       }];
}
@end
