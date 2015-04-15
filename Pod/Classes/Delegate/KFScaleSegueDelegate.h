//
//  KFScaleSegueDelegate.h
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, KFScaleSegueMoveDirection) {
    KFScaleSegueMoveFromLeft,
    KFScaleSegueMoveFromRight
};

@protocol KFScaleSegueDelegate <NSObject>
-(KFScaleSegueMoveDirection)kf_DirectionToMove;
-(CGFloat) kf_WidthRemainOfHoldView;
-(CGFloat) kf_ScaleOfHoldView;
@end
