#import "RightViewController.h"

@implementation RightViewController
#pragma mark - KFScaleSegueDelegate
-(KFScaleSegueMoveDirection)kf_DirectionToMove{
    return KFScaleSegueMoveFromRight;
}
-(CGFloat)kf_ScaleOfHoldView{return 0.8f;}
-(CGFloat)kf_WidthRemainOfHoldView{return 96.f;}
@end
