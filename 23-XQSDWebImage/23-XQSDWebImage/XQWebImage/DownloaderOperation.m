//
//  DownloaderOperation.m
//  23-XQSDWebImage
//
//  Created by sdos on 2017/8/18.
//  Copyright © 2017年 乔现宁. All rights reserved.
//

#import "DownloaderOperation.h"
/*
 负责图片下载
 1. 需要图片网络地址(URL)
 2.
 */

@interface DownloaderOperation()

/// 接受外界传入的图片地址
@property(nonatomic,copy)   NSString    * urlString;
/// B2. 接收外界传入的代码块
@property(nonatomic,copy)   void(^finishedBlock)(UIImage *);

@end

@implementation DownloaderOperation

+ (instancetype)downloaderOperationWithUrlString:(NSString *)urlString finished:(void (^)(UIImage *))finishedBlock{
    
    // 创建自定义操作对象
    DownloaderOperation *op = [[DownloaderOperation alloc] init];
    
    // 记录外界传入的数据
    op.urlString = urlString;
    op.finishedBlock = finishedBlock;
    
    return op;
}

// main函数 只在 队列调度操作之后才执行  该方法默认在子线程执行
// 重写main方法的作用 : 可以在该方法里指定自定义操作要执行的代码
- (void)main{
    NSLog(@"传入地址  %@",self.urlString);
    
    NSURL *url = [NSURL URLWithString:_urlString];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    
    
    // B4. 图片下载完成之后,需要回调到外界
    if (_finishedBlock != nil) {
        // 回调block 在main方法中即为在子线程回调执行  外界使用该框架 刷新UI操作是在主线程 因此,此处不能这么写 需要回到主线程 框架使用者拿到这个东西就是要在主线程使用, 所以修改线程 
//        self.finishedBlock(image);
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.finishedBlock(image);
        }];
    }
}

@end
