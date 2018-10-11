//
//  UIViewController+CZAddition.m
//
//

#import "UIViewController+CZAddition.h"

@implementation UIViewController (CZAddition)

- (void)cz_addChildController:(UIViewController *)childController intoView:(UIView *)view  {
    
    [self addChildViewController:childController];
    
    [view addSubview:childController.view];
    
    [childController didMoveToParentViewController:self];
}

@end
