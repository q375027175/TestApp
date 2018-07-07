//
//  NSData+Aes.h
//  TongYi
//
//  Created by 聚格科技 on 2017/8/1.
//  Copyright © 2017年 聚格科技. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 没有256加密， 全部都是128加密

@interface NSData (Aes)


+(NSString *) aes256_encrypt:(NSString *)key Encrypttext:(NSString *)text;
+(NSString *) aes256_decrypt:(NSString *)key Decrypttext:(NSString *)text;

- (NSData *)AES256EncryptWithKey:(NSString *)key;
/**
 AES 128 加密
    加密模式 ECB 填充 PKCS7Padding 输出用base64 编码
 @param plaintext 加密内容
 @param key key
 @return 加密后的字符串
 */
+ (NSString *)aes128_encrpt:(NSString *)plaintext key:(NSString *)key;

/*加密方法*/
+ (NSString *)AES256EncryptWithPlainText:(NSString *)plain key:(NSString *)key;

+ (NSString *)AES256DecryptWithCiphertext:(NSString *)ciphertexts key:(NSString *)key;

+ (NSData *)AES128EncryptWithKey:(NSString *)key iv:(NSString *)iv withNSData:(NSData *)data;

@end
