//
//  ViewController.m
//  KVCDemo
//
//  Created by dnnta on 13-11-20.
//  Copyright (c) 2013年 NightWish. All rights reserved.
//

#import "ViewController.h"
#import "APIClient.h"
#import "Video.h"
#import "NSObject+Property.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[APIClient sharedClient] fetchVideo:@"XNjM3NjE0MTI4" completion:^(NSDictionary *dic, NSError *error) {
        Video *video = [[Video alloc] initWithAttributes:dic];
        NSLog(@"%@", [video valueForKeyPath:@"user.link"]);
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
