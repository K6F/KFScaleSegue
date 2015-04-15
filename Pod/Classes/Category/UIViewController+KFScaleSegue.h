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
