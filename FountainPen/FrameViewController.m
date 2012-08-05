
#import "FrameViewController.h"

#import "FountainPen.h"

@interface FrameViewController ()
@end

@implementation FrameViewController
@synthesize targetView;

- (void)viewDidUnload
{
    [self setTargetView:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)left        { self.targetView.x -= 10; }
- (IBAction)right       { self.targetView.x += 10; }
- (IBAction)up          { self.targetView.y -= 10; }
- (IBAction)down        { self.targetView.y += 10; }
- (IBAction)minusWidth  { self.targetView.w -= 10; }
- (IBAction)plusWidth   { self.targetView.w += 10; }
- (IBAction)minusHeight { self.targetView.h -= 10; }
- (IBAction)plusHeight  { self.targetView.h += 10; }

@end
