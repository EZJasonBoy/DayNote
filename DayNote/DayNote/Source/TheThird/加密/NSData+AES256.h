//
//  NSData+AES256.h
//  iOS加密
//
//  Created by boluchuling on 15/11/3.
//  Copyright © 2015年 郭兆伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@interface NSData (AES256)
- (NSData *)aes256_encrypt:(NSString *)key;
- (NSData *)aes256_decrypt:(NSString *)key;
@end
