//
//  UILabel+CZAddition.m
//
//

#import "UILabel+CZAddition.h"

@implementation UILabel (CZAddition)

+ (instancetype)cz_labelWithText:(NSString *)text fontSize:(CGFloat)fontSize color:(UIColor *)color {
    UILabel *label = [[self alloc] init];
    
    label.text = text;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textColor = color;
    label.numberOfLines = 1;
    
    [label sizeToFit];
    
    return label;
}

+ (CGFloat)cz_labelHeightWithText:(NSString *)text size:(CGSize)rectSize font:(UIFont *)font{
    if (text == nil){
        return 0.0f;
    }
    
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.lineBreakMode = NSLineBreakByWordWrapping;
    style.alignment = NSTextAlignmentLeft;
    
    NSAttributedString *string = [[NSAttributedString alloc]initWithString:text attributes:@{NSFontAttributeName:font, NSParagraphStyleAttributeName:style}];
    //CGSizeMake(200.f, MAXFLOAT)
    CGSize size =  [string boundingRectWithSize:rectSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
    NSLog(@" size =  %@", NSStringFromCGSize(size));
    
    //在原来计算的基础上 取ceil值，再加1；
    CGFloat height = ceil(size.height) + 1;
    return height;
    

}

@end
