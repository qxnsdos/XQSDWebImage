//
//  ViewController.m
//  23-XQSDWebImage
//
//  Created by sdos on 2017/8/18.
//  Copyright © 2017年 乔现宁. All rights reserved.
//

#import "ViewController.h"
#import "DownloaderOperation.h"

@interface ViewController ()

@property(nonatomic,strong)   NSOperationQueue    * queue;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建队列
    self.queue = [[NSOperationQueue alloc] init];
    
    // 创建操作
    DownloaderOperation *op = [[DownloaderOperation alloc] init];
    
    //传入图片地址
    op.urlString = @"http://pic.58pic.com/58pic/13/15/14/34E58PICuHd_1024.jpg";
    
    // B1. 准备代码块  内部写入 你拿到参数后 需要干的事情  打印/刷新UI
    void(^finishedBlock)(UIImage *) = ^(UIImage *image){
        
        NSLog(@"%@  %@",image,[NSThread currentThread]);
        
    };
    // B3. 传递代码块
    op.finishedBlock = finishedBlock;
    
    
    // 把操作添加到队列
    [self.queue addOperation:op];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
