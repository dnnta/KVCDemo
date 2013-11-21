//
//  NSObject+Property.m
//  KVCDemo
//
//  Created by dnnta on 13-11-20.
//  Copyright (c) 2013年 NightWish. All rights reserved.
//

#import "NSObject+Property.h"
#import <objc/runtime.h>

@implementation NSObject (Property)

- (id)initWithAttributes:(NSDictionary *)dic
{
    self = [self init];
    if (self == nil) {
        return nil;
    }
    if (!dic || [dic allKeys].count == 0) {
        return self;
    }
    unsigned int outCount, index;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (index=0; index<outCount; index++) {
        objc_property_t p = properties[index];
        NSString *key = [NSString stringWithUTF8String:property_getName(p)];
        
        id value = [dic valueForKey:key];
        if (!value) {
            [self setValue:dic forUndefinedKey:key];
            continue;
        }
        char *typeEncoding = NULL;
        typeEncoding = property_copyAttributeValue(p, "T");
        if (!typeEncoding) {
            continue;
        }
        char type = typeEncoding[0];
        switch (type) {
            case '@':
            {
                Class class = nil;
                if (strlen(typeEncoding) >= 3) {
                    char *className = strndup(typeEncoding+2, strlen(typeEncoding)-3);
                    class = objc_getClass(className);
                    free(className);
                }
                if ([class isSubclassOfClass:[NSString class]] && [value isKindOfClass:[NSNumber class]]) {
                    value = [value stringValue];
                } else if([class isSubclassOfClass:[NSNumber class]]
                          && [value isKindOfClass:[NSString class]]) {
                    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
                    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
                    value = [formatter numberFromString:value];
                } else {
                    NSString *className = NSStringFromClass(class);
                    if ([className isEqualToString:@"User"]) {
                        value = [[class alloc] initWithAttributes:value];
                    }                    
                }
                break;
            }
            case 'i': // int
            case 's': // short
            case 'l': // long
            case 'q': // long long
            case 'I': // unsigned int
            case 'S': // unsigned short
            case 'L': // unsigned long
            case 'Q': // unsigned long long
            case 'f': // float
            case 'd': // double
            case 'B': // BOOL
            {
                if ([value isKindOfClass:[NSString class]]) {
                    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
                    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
                    value = [formatter numberFromString:value];
                }
                break;
            }
            case 'c': // char
            case 'C': // unsigned char
            {
                if ([value isKindOfClass:[NSString class]]) {
                    char firstChar = [value characterAtIndex:0];
                    value = [NSNumber numberWithChar:firstChar];
                }
                break;
            }
            default:
                break;
        }
        
        [self setValue:value forKey:key];
        free(typeEncoding);
    }
    free(properties);
    
    return self;
}

@end
