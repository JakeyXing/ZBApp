//
//  CommonMethod.m
//  ZBApp
//
//  Created by   xingjiehai on 2018/10/16.
//  Copyright © 2018 ParentsChat. All rights reserved.
//

#import "CommonMethod.h"

@implementation CommonMethod
//照片获取本地路径转换
+ (NSString *)getImagePath:(UIImage *)Image imageName:(NSString *)imageName{
    //    UIImage *sizedImage = [self imageWithImageSimple:Image scaledToSize:CGSizeMake(1080, 1080)];
    
    NSString *filePath = nil;
    NSData *data = nil;
    
    data = UIImageJPEGRepresentation(Image, 0.7);
    //    if (UIImagePNGRepresentation(Image) == nil) {
    //        data = UIImageJPEGRepresentation(Image, 0.6);
    //    } else {
    //        data = UIImagePNGRepresentation(Image);
    //    }
    
    //图片保存的路径
    //这里将图片放在沙盒的documents文件夹中
    NSString *DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    //文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //把刚刚图片转换的data对象拷贝至沙盒中
    [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
    NSString *ImagePath = [[NSString alloc] initWithFormat:@"/%@.png",imageName];
    [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:ImagePath] contents:data attributes:nil];
    
    //得到选择后沙盒中图片的完整路径
    filePath = [[NSString alloc] initWithFormat:@"%@%@", DocumentsPath, ImagePath];
    return filePath;
}

//生成时间戳
+ (NSString *)timestamp{
    NSDate *date = [NSDate date];
    NSDateFormatter *formater = [[NSDateFormatter alloc]init];
    formater.dateFormat = @"YYYYMMddHHmmssSSS";
    NSString *result = [formater stringFromDate:date];
    return result;
}
@end
