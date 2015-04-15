//
//  UIViewController+TLScaleSegue.h
//

#import <UIKit/UIKit.h>
#import "KFScaleSegueDelegate.h"

@interface UIViewController (TLScaleSegue)
@property (nonatomic,strong) UIViewController * sourceViewController;
@property (nonatomic, strong) UIImageView * sourceViewControllerImageView;
/**
 *  @author K6F, 2014-50[3]
 *
 *  add background to  UIApplication keyWindow
 *
 *  @param image background image
 */
-(void)kf_addWindowBackground:(UIImage *)image;
/**
 *  @author Khiyuan.Fan, 2014-50[3]
 *
 *  dismiss
 */
-(void)kf_unwindSegue;
@end
