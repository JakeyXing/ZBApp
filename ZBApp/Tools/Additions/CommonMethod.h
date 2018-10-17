//
//  CommonMethod.h
//  ZBApp
//
//  Created by   xingjiehai on 2018/10/16.
//  Copyright © 2018 ParentsChat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface CommonMethod : NSObject
+ (NSString *)getImagePath:(UIImage *)Image imageName:(NSString *)imageName;
+ (void) convertVideoQuailtyWithInputURL:(NSURL*)inputURL
                               outputURL:(NSURL*)outputURL
                         completeHandler:(void (^)(AVAssetExportSession*))handler;
+ (UIImage*) getVideoPreViewImage:(NSURL *)path;
//生成时间戳
+ (NSString *)timestamp;
@end
