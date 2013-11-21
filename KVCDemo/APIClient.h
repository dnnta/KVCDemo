//
//  APIClient.h
//  KVCDemo
//
//  Created by dnnta on 13-11-20.
//  Copyright (c) 2013年 NightWish. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ResponseBlock)(NSDictionary *, NSError *);

@interface APIClient : NSObject

+ (id)sharedClient;

- (void)fetchVideo:(NSString *)vid completion:(ResponseBlock)block;

@end
