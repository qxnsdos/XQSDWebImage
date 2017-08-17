//
//  DownloaderOperation.m
//  23-XQSDWebImage
//
//  Created by sdos on 2017/8/18.
//  Copyright © 2017年 乔现宁. All rights reserved.
//

#import "DownloaderOperation.h"

@implementation DownloaderOperation

// main函数 只在 队列调度操作之后才执行  该方法默认在子线程执行
// 重写main方法的作用 : 可以在该方法里指定自定义操作要执行的代码
- (void)main{
    NSLog(@"main  %@",[NSThread currentThread]);
    
    NSData *data = [NSData dataWithContentsOfURL:nil];
    
}

@end
