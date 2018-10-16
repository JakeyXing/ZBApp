//
//  CommonMethod.h
//  ZBApp
//
//  Created by   xingjiehai on 2018/10/16.
//  Copyright © 2018 ParentsChat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CommonMethod : NSObject
+ (NSString *)getImagePath:(UIImage *)Image imageName:(NSString *)imageName;
//生成时间戳
+ (NSString *)timestamp;
@end
