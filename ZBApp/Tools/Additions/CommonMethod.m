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
    UIImage *sizedImage = [self imageWithImageSimple:Image scaledToSize:CGSizeMake(750, 750)];
    
    NSString *filePath = nil;
    NSData *data = nil;
    
    data = UIImageJPEGRepresentation(sizedImage, 0.7);
    //    if (UIImagePNGRepresentation(Image) == nil) {
    //        data = UIImageJPEGRepresentation(Image, 0.6);
    //    } else {
    //        data = UIImagePNGRepresentation(Image);
    //    }
    
    //图片保存的路径
    NSString *documentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *awsFilesPath = [documentsPath stringByAppendingPathComponent:@"awsFiles"];
 
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager createDirectoryAtPath:awsFilesPath withIntermediateDirectories:YES attributes:nil error:nil];
    NSString *ImagePath = [[NSString alloc] initWithFormat:@"/%@.png",imageName];
    [fileManager createFileAtPath:[awsFilesPath stringByAppendingString:ImagePath] contents:data attributes:nil];
    
    //得到选择后沙盒中图片的完整路径
    filePath = [[NSString alloc] initWithFormat:@"%@%@", awsFilesPath, ImagePath];
    return filePath;
}
    
+ (void)deleteAwsFiles{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *document=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *folder =[document stringByAppendingPathComponent:@"awsFiles"];
  
    NSArray *fileList =[fileManager contentsOfDirectoryAtPath:folder error:NULL];
    
    for (NSString *file in fileList) {
        NSLog(@"file=%@",file);
        NSString *path =[folder stringByAppendingPathComponent:file];
        NSLog(@"得到的路径=%@",path);
        
    }
}

//修改图片大小
+ (UIImage *)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize{
    newSize.height=image.size.height*(newSize.width/image.size.width);
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  newImage;
    
}

//生成时间戳
+ (NSString *)timestamp{
    NSDate *date = [NSDate date];
    NSDateFormatter *formater = [[NSDateFormatter alloc]init];
    formater.dateFormat = @"YYYYMMddHHmmssSSS";
    NSString *result = [formater stringFromDate:date];
    return result;
}

+ (void) convertVideoQuailtyWithInputURL:(NSURL*)inputURL
                               outputURL:(NSURL*)outputURL
                         completeHandler:(void (^)(AVAssetExportSession*))handler{
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:inputURL options:nil];
    
    AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPresetMediumQuality];
    //  NSLog(resultPath);
    exportSession.outputURL = outputURL;
    exportSession.outputFileType = AVFileTypeMPEG4;
    exportSession.shouldOptimizeForNetworkUse= YES;
    [exportSession exportAsynchronouslyWithCompletionHandler:^(void)
     {
         switch (exportSession.status) {
             case AVAssetExportSessionStatusCancelled:
                 NSLog(@"AVAssetExportSessionStatusCancelled");
                 break;
             case AVAssetExportSessionStatusUnknown:
                 NSLog(@"AVAssetExportSessionStatusUnknown");
                 break;
             case AVAssetExportSessionStatusWaiting:
                 NSLog(@"AVAssetExportSessionStatusWaiting");
                 break;
             case AVAssetExportSessionStatusExporting:
                 NSLog(@"AVAssetExportSessionStatusExporting");
                 break;
             case AVAssetExportSessionStatusCompleted:
                 NSLog(@"AVAssetExportSessionStatusCompleted");
                 
                 if (handler) {
                     handler(exportSession);
                 }
                 //UISaveVideoAtPathToSavedPhotosAlbum([outputURL path], self, nil, NULL);//这个是保存到手机相册
                 
                 break;
             case AVAssetExportSessionStatusFailed:
                 NSLog(@"AVAssetExportSessionStatusFailed");
                 break;
         }
         
     }];
    
    
}

+ (void) convertVideoWithFileName:(NSString *)filename assetFilePath:(NSURL*)assetFilePath completeHandler:(void (^)(NSString*))handler{
   
    //保存至沙盒路径
    NSString *pathDocuments = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *videoPath = [NSString stringWithFormat:@"%@/Image", pathDocuments];
    NSString *sandBoxFilePath = [videoPath stringByAppendingPathComponent:filename];
    
    //转码配置
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:assetFilePath options:nil];
    AVAssetExportSession *exportSession= [[AVAssetExportSession alloc] initWithAsset:asset presetName:AVAssetExportPresetMediumQuality];
    exportSession.shouldOptimizeForNetworkUse = YES;
    exportSession.outputURL = [NSURL fileURLWithPath:sandBoxFilePath];
    exportSession.outputFileType = AVFileTypeMPEG4;
    [exportSession exportAsynchronouslyWithCompletionHandler:^{
        int exportStatus = exportSession.status;
      
        switch (exportStatus)
        {
            case AVAssetExportSessionStatusFailed:
            {
                // log error to text view
                NSError *exportError = exportSession.error;
                NSLog (@"AVAssetExportSessionStatusFailed: %@", exportError);
                break;
            }
            case AVAssetExportSessionStatusCompleted:
            {
                NSLog(@"视频转码成功");
//                NSData *data = [NSData dataWithContentsOfFile:sandBoxFilePath];
                handler(sandBoxFilePath);
            }
        }
    }];
    
}

// 获取视频第一帧
+ (UIImage*) getVideoPreViewImage:(NSURL *)path{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:path options:nil];
    AVAssetImageGenerator *assetGen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    assetGen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [assetGen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *videoImage = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return videoImage;
}
@end
