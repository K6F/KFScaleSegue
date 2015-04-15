/** The MIT License (MIT)

Copyright (c) 2015 K6F <Fan.Khiyuan@gmail.com>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
**/

#import "KFScaleSegue.h"
#import "KFScaleSegueDelegate.h"
#import "UIViewController+KFScaleSegue.h"

struct kfScaleData {
    KFScaleSegueMoveDirection direction;
//    CGAffineTransform transform;
    // sourceViewController
    CGFloat srcVRemainWidth;
    CGFloat srcVScale;
    CGRect srcVStartFrame;
    CGRect srcVEndFrame;
    // destinationViewController
    CGRect dstVStartFrame;
    CGRect dstVEndFrame;
};
typedef struct kfScaleData kfScaleData;

@implementation KFScaleSegue{
    UIViewController<KFScaleSegueDelegate> *dstVC;
    UIViewController *srcVC;
    
    CGFloat p_viewRemain;
    CGFloat p_viewScale;
    KFScaleSegueMoveDirection p_direction;
}
-(void)perform{
    dstVC = self.destinationViewController;
    srcVC = self.sourceViewController;
    
    //添加目标控制器;
    [dstVC viewWillAppear:NO];
    [dstVC viewDidAppear:NO];
    id mainWindow = srcVC.view.superview;
    if (!mainWindow) mainWindow = [[UIApplication sharedApplication].windows objectAtIndex:0];
    if (![[mainWindow subviews] containsObject:dstVC.view]) {
        [mainWindow addSubview:dstVC.view];
        NSLog(@"Destination View Controller added");
    }
    
    // 截图
    UIImageView * sourceVCImageView = [[UIImageView alloc]initWithImage:[self p_viewSnapshot:srcVC.view]];
    
    // 初始化
    kfScaleData sData = [self scaleData];
    
    [dstVC.view addSubview:sourceVCImageView];
    sourceVCImageView.frame = sData.srcVStartFrame;
    dstVC.view.frame = sData.dstVStartFrame;
    
    
    // 替换UI
    UINavigationController *nav = [[self sourceViewController] navigationController];
    if (nav) {
        [nav popViewControllerAnimated:NO];
        [nav pushViewController:self.destinationViewController animated:NO];
    }else{
        [self.sourceViewController presentModalViewController:dstVC animated:NO];
    }
    
    // 开始动画
    [UIView animateWithDuration:0.6f animations:^{
        dstVC.view.frame = sData.dstVEndFrame;
//        sourceVCImageView.transform = sData.transform;
        sourceVCImageView.frame = sData.srcVEndFrame;
    } completion:^(BOOL finished){
        dstVC.sourceViewControllerImageView = sourceVCImageView;
        dstVC.sourceViewController = self.sourceViewController;
    }];
}
-(kfScaleData)scaleData{
    CGFloat srcVRemainWidth = ([dstVC respondsToSelector:@selector(kf_WidthRemainOfHoldView)])? [dstVC kf_WidthRemainOfHoldView] : 40.f;
    CGFloat srcVScale       = ([dstVC respondsToSelector:@selector(kf_ScaleOfHoldView)])? [dstVC kf_ScaleOfHoldView] : 1.f;
    
    kfScaleData sData;
    sData.direction        = ([dstVC respondsToSelector:@selector(kf_DirectionToMove)])? [dstVC kf_DirectionToMove] : KFScaleSegueMoveFromLeft;
//    sData.transform = CGAffineTransformScale(srcVC.view.transform, srcVScale, srcVScale);
    sData.dstVEndFrame = srcVC.view.frame;
    
    CGFloat startOffsetX,srcVEndX,srcVEndY,srcVEndW,srcVEndH;
    srcVEndY = sData.dstVEndFrame.size.height * (1 - srcVScale)/2;
    srcVEndW = sData.dstVEndFrame.size.width  * srcVScale;
    srcVEndH = sData.dstVEndFrame.size.height * srcVScale;
    if (KFScaleSegueMoveFromLeft == sData.direction) {
        startOffsetX = -sData.dstVEndFrame.size.width;
        srcVEndX = sData.dstVEndFrame.size.width - srcVRemainWidth;
    }else{
        startOffsetX = sData.dstVEndFrame.size.width;
        srcVEndX = -(sData.dstVEndFrame.size.width * srcVScale - srcVRemainWidth);
    }
    sData.srcVStartFrame = CGRectOffset(sData.dstVEndFrame, -startOffsetX, 0);
    sData.dstVStartFrame = CGRectOffset(sData.dstVEndFrame,  startOffsetX, 0);
    sData.srcVEndFrame = CGRectMake(srcVEndX, srcVEndY, srcVEndW, srcVEndH);
    return sData;
}
#pragma mark - private helper
-(UIImage *)p_viewSnapshot:(UIView *)capture_view{
    //支持retina高分的关键
    if([self p_isRetina]){
        UIGraphicsBeginImageContextWithOptions(capture_view.frame.size, NO, 0.0);
    }else {
        UIGraphicsBeginImageContext(capture_view.frame.size);
    }
    //获取图像
    
    [capture_view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
-(BOOL)p_isRetina{
    return ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] && ([UIScreen mainScreen].scale == 2.0));
}
@end
