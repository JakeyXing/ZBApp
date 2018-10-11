//
//  UIView+CZAddition.m
//
//

#import "UIView+CZAddition.h"

@implementation UIView (CZAddition)

- (UIImage *)cz_snapshotImage {

    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0);
    
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return result;
}

@end
