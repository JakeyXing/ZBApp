//
//  NSString+CZBase64.h
//
//

#import <Foundation/Foundation.h>

@interface NSString (CZBase64)

/// 对当前字符串进行 BASE 64 编码，并且返回结果
- (NSString *)cz_base64Encode;

/// 对当前字符串进行 BASE 64 解码，并且返回结果
- (NSString *)cz_base64Decode;

@end
