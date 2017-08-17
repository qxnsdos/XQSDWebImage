//
//  DownloaderOperation.m
//  23-XQSDWebImage
//
//  Created by sdos on 2017/8/18.
//  Copyright © 2017年 乔现宁. All rights reserved.
//

#import "DownloaderOperation.h"
#import <UIKit/UIKit.h>
/*
 负责图片下载
 1. 需要图片网络地址(URL)
 2.
 */

@implementation DownloaderOperation

// main函数 只在 队列调度操作之后才执行  该方法默认在子线程执行
// 重写main方法的作用 : 可以在该方法里指定自定义操作要执行的代码
- (void)main{
    NSLog(@"传入地址  %@",self.urlString);
    
    NSURL *url = [NSURL URLWithString:_urlString];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    
    NSLog(@"image  %@",image);
}

@end
