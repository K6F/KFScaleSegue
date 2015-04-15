//
//  LeftViewController.m
//  KFScaleSegue-demo
//
//  Created by K6F on 15/4/14.
//  Copyright (c) 2015年 k6f. All rights reserved.
//

#import "LeftViewController.h"

@implementation LeftViewController
#pragma mark - KFScaleSegueDelegate
-(KFScaleSegueMoveDirection)kf_DirectionToMove{
    return KFScaleSegueMoveFromLeft;
}
-(CGFloat)kf_ScaleOfHoldView{return 0.8f;}
-(CGFloat)kf_WidthRemainOfHoldView{return 96.f;}
@end
