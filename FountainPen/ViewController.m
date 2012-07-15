

#import "ViewController.h"

#import "FountainPen/FountainPen.h"

@interface ShObj : FPSharedInstance
@end
@implementation ShObj
@end

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)touchedAlertButton:(id)sender
{
    ShObj *so = [ShObj sharedInstance];
    fp(@"ShObj a0 %@", so);
    
    [FPAlert show:@"Title"
          message:@"Message"
           cancel:@"Cancel"
           others:[NSArray arrayWithObjects:@"A", @"B", nil]
       completion:^(FPAlertResponse *alert) {
           if (alert.isCancel) {
               fp(@"alert cancel");
               return;
           }
           
           fp(@"alert others %d", alert.index);
       }];
}

- (IBAction)touchedSheetButton:(id)sender
{
    ShObj *so = [ShObj sharedInstance];
    fp(@"ShObj b0 %@", so);
    
    [FPSheet show:@"Title"
           cancel:@"Cancel"
      destructive:@"Destructive"
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
           
           fp(@"sheet others %d", sheet.index);
       }];
}
@end
