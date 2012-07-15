

#import "ViewController.h"

#import "FountainPen/FountainPen.h"

@interface SO : FPSharedInstance
@end
@implementation SO
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
    SO *so = [SO sharedInstance];
    fp(@"so a0 %@", so);
    
    [FPAlert show:@"Title"
          message:@"Message"
           cancel:@"Cancel"
           others:[NSArray arrayWithObjects:@"A", @"B", nil]
       completion:^(FPAlertResponse *alert) {
           if (alert.isCancel) {
               return;
           }
           
           SO *so = [SO sharedInstance];
           fp(@"so a1 %@", so);
       }];
}

- (IBAction)touchedSheetButton:(id)sender
{
    SO *so = [SO sharedInstance];
    fp(@"so b0 %@", so);
    
    [FPSheet show:@"Title"
           cancel:@"Cancel"
      destructive:@"Destructive"
           others:[NSArray arrayWithObjects:@"A", @"B", nil]
       completion:^(FPSheetResponse *sheet) {
           if (sheet.isCancel) {
               return;
           }
           if (sheet.isDestructive) {
               return;
           }
           
           SO *so = [SO sharedInstance];
           fp(@"so b1 %@", so);
       }];
}
@end
