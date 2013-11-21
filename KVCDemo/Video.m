//
//  Video.m
//  KVCDemo
//
//  Created by dnnta on 13-11-20.
//  Copyright (c) 2013年 NightWish. All rights reserved.
//

#import "Video.h"

@implementation Video


- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSDictionary *dic = value;
    if ([key isEqualToString:@"vid"]) {
        _vid = dic[@"id"];
    }
}

@end
