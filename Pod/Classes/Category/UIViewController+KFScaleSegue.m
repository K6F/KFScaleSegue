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

#import "UIViewController+KFScaleSegue.h"
#import "KFScaleSegueDelegate.h"
#import <objc/runtime.h>

static const void *sourceVCImageViewKey = &sourceVCImageViewKey;
static const void *sourceVCKey = &sourceVCKey;

@implementation UIViewController (KFScaleSegue)
#pragma mark - property
-(void)setSourceViewController:(UIViewController *)sourceViewController{
    objc_setAssociatedObject(self, sourceVCKey, sourceViewController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(UIImageView *) sourceViewControllerImageView{
    return objc_getAssociatedObject(self, sourceVCImageViewKey);
}
-(void) setSourceViewControllerImageView:(UIImageView *)svcImageView{
    objc_setAssociatedObject(self, sourceVCImageViewKey, svcImageView , OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self p_BindGestureToImageView:svcImageView];
}
#pragma mark - background
-(void)addWindowBackground:(UIImage *)image{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    // 修改全局背景色
    UIColor *bgColor = [UIColor colorWithPatternImage: image];
    window.backgroundColor = bgColor;
}
-(void)removeWindowBackground{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    window.backgroundColor = [UIColor whiteColor];
}
#pragma mark - unwind animate method
-(void)kf_unwindSegue{
    // 初始化
    KFScaleSegueMoveDirection direction = ([self respondsToSelector:@selector(kf_DirectionToMove)])? [(UIViewController<KFScaleSegueDelegate>  *)self kf_DirectionToMove] : KFScaleSegueMoveFromLeft;
    UIImageView * sourceVCImageView = [self sourceViewControllerImageView];
    // 开始动画
    CGRect f = self.view.frame;
    [UIView animateWithDuration:0.4f animations:^{
//        sourceVCImageView.transform =  CGAffineTransformScale(sourceVCImageView.transform, holdScale, holdScale);
        CGFloat offsetX = (KFScaleSegueMoveFromLeft == direction)? -f.size.width : f.size.width;
        self.view.frame = CGRectOffset(f, offsetX, 0);
        sourceVCImageView.frame = CGRectOffset(f,-offsetX, 0);
    } completion:^(BOOL finished){
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}
#pragma mark - config
-(void)p_BindGestureToImageView:(UIImageView *)svcImageView{
    svcImageView.userInteractionEnabled = YES;
    [svcImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(p_clickImage:)]];
    UIPanGestureRecognizer * panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(p_panFromEdge:)];
    //    panRecognizer.edges = UIRectEdgeRight;
    [svcImageView addGestureRecognizer:panRecognizer];
}
#pragma mark - Segue Action
-(void)p_clickImage:(UITapGestureRecognizer *)gestureRecognizer
{
    [self kf_unwindSegue];
}
-(void)p_panFromEdge:(UIPanGestureRecognizer *)gestureRecognizer{
    static float startOffsetX;
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        startOffsetX = [gestureRecognizer translationInView:self.view].x;
    }else if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        KFScaleSegueMoveDirection direction = ([self respondsToSelector:@selector(kf_DirectionToMove)])? [(UIViewController<KFScaleSegueDelegate>  *)self kf_DirectionToMove] : KFScaleSegueMoveFromLeft;
        float offsetX = startOffsetX - [gestureRecognizer translationInView:self.view].x;
        float progress =fabsf(offsetX / (self.view.bounds.size.width*1.f));
        if (KFScaleSegueMoveFromLeft == direction && startOffsetX > 0.0001f) return;
        if (KFScaleSegueMoveFromRight == direction && startOffsetX < 0.0001f) return;
        if (0.3 < progress) {
            [self kf_unwindSegue];
        }
    }
}

@end
