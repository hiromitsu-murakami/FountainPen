
#import <UIKit/UIKit.h>

@interface FrameViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *targetView;

- (IBAction)left;
- (IBAction)right;
- (IBAction)up;
- (IBAction)down;
- (IBAction)minusWidth;
- (IBAction)plusWidth;
- (IBAction)minusHeight;
- (IBAction)plusHeight;

@end
