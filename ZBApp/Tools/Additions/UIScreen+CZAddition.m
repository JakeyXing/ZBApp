//
//  UIScreen+CZAddition.m
//
//

#import "UIScreen+CZAddition.h"

@implementation UIScreen (CZAddition)

+ (CGFloat)cz_screenWidth {
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat)cz_screenHeight {
    return [UIScreen mainScreen].bounds.size.height;
}

+ (CGFloat)cz_scale {
    return [UIScreen mainScreen].scale;
}

@end
