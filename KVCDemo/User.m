//
//  User.m
//  KVCDemo
//
//  Created by dnnta on 13-11-20.
//  Copyright (c) 2013年 NightWish. All rights reserved.
//

#import "User.h"

@implementation User

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSDictionary *dic = value;
    if ([key isEqualToString:@"uid"]) {
        _uid = dic[@"id"];
    }
}

@end
