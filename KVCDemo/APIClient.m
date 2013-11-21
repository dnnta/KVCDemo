//
//  APIClient.m
//  KVCDemo
//
//  Created by dnnta on 13-11-20.
//  Copyright (c) 2013年 NightWish. All rights reserved.
//

#import "APIClient.h"

#define kAPIVideoURL   @"https://openapi.youku.com/v2/videos/show.json"

@implementation APIClient

+ (id)sharedClient
{
    static APIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[APIClient alloc] init];
    });
    return _sharedClient;
}

- (void)fetchVideo:(NSString *)vid completion:(ResponseBlock)block
{
    NSURL *url = [NSURL URLWithString:kAPIVideoURL];
    
    NSString *params = [NSString stringWithFormat:@"client_id=776811adc0d666ad&video_id=%@", vid];
    NSData *data = [params dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:data];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:queue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               if (connectionError) {
                                   NSLog(connectionError, nil);
                               } else {
                                   
                                   NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
                                   
                                   if (responseCode == 200) {
                                       NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data
                                                                                           options:NSJSONReadingAllowFragments
                                                                                             error:nil];
                                       if (block) {
                                           block(dic, nil);
                                       }
                                   } else {
                                       NSLog(connectionError, nil);
                                   }
                               }
                               
                           }];
}


@end
