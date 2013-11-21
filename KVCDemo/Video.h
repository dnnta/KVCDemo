//
//  Video.h
//  KVCDemo
//
//  Created by dnnta on 13-11-20.
//  Copyright (c) 2013年 NightWish. All rights reserved.
//

#import <Foundation/Foundation.h>
@class User;

@interface Video : NSObject

@property (nonatomic, strong) NSString *vid;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *link;
@property (nonatomic, strong) NSString *thumbnail;
@property (nonatomic, assign) int duration;
@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *published;
@property (nonatomic, strong) NSString *player;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *public_type;
@property (nonatomic, strong) NSString *copyright_type;
@property (nonatomic, strong) NSArray *operation_limit;
@property (nonatomic, strong) NSArray *streamtypes;
@property (nonatomic, strong) User *user;

@end
