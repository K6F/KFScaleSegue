#import "LeftViewController.h"

@implementation LeftViewController
#pragma mark - KFScaleSegueDelegate
-(KFScaleSegueMoveDirection)kf_DirectionToMove{
    return KFScaleSegueMoveFromLeft;
}
-(CGFloat)kf_ScaleOfHoldView{return 0.8f;}
-(CGFloat)kf_WidthRemainOfHoldView{return 96.f;}
@end
