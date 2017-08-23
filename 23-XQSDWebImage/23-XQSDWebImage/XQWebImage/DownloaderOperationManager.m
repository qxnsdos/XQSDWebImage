//
//  DownloaderOperationManager.m
//  23-XQSDWebImage
//
//  Created by sdos on 2017/8/23.
//  Copyright © 2017年 乔现宁. All rights reserved.
//

#import "DownloaderOperationManager.h"

@interface DownloaderOperationManager()

/// 队列
@property(nonatomic,strong)   NSOperationQueue      * queue;
/// 下载操作缓存池
@property(nonatomic,strong)   NSMutableDictionary   * opCache;

@end


/**
 1. 单例管理下载
 */
@implementation DownloaderOperationManager

+ (instancetype)sharedManager{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init{
    if (self = [super init]) {
        self.queue = [[NSOperationQueue alloc] init];
        self.opCache = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)downloadImageWithUrlStr:(NSString *)urlStr finished:(void (^)(UIImage *))finishedBlock{
    
    // 在建立下载操作之前,判断要建立的下载操作是否存在 (连续传入的图片地址一样)
    if ([self.opCache objectForKey:urlStr] != nil) {
        return;
    }
    
    // finishedBlock : VC传入的代码块
    // 此处代码块 : 单例定义的代码块 传给 DownloaderOperation  等到op下载完就回调
    void(^instanceFinishedBlock)(UIImage *) = ^(UIImage *image){
        // 回调VC传入的代码块 把image回调给VC
        if (finishedBlock != nil) {
            finishedBlock(image);
        }
        
        // 移除下载操作缓存池里的操作
        [self.opCache removeObjectForKey:urlStr];
    };
    // 把随机图片地址传入 DownloaderOperation
    DownloaderOperation *op = [DownloaderOperation downloaderOperationWithUrlString:urlStr finished:instanceFinishedBlock];
    
    // 把下载操作添加到操作缓存池
    [self.opCache setObject:op forKey:urlStr];
    
    // 把操作添加到队列
    [self.queue addOperation:op];
}

@end
