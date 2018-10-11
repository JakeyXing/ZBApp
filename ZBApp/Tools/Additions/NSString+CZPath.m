//
//  NSString+CZPath.m
//
//

#import "NSString+CZPath.h"

@implementation NSString (CZPath)

- (NSString *)cz_appendDocumentDir {
    NSString *dir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    
    return [dir stringByAppendingPathComponent:self.lastPathComponent];
}

- (NSString *)cz_appendCacheDir {
    NSString *dir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    
    return [dir stringByAppendingPathComponent:self.lastPathComponent];
}

- (NSString *)cz_appendTempDir {
    NSString *dir = NSTemporaryDirectory();
    
    return [dir stringByAppendingPathComponent:self.lastPathComponent];
}

@end
