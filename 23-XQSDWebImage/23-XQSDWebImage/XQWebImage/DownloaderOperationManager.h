//
//  DownloaderOperationManager.h
//  23-XQSDWebImage
//
//  Created by sdos on 2017/8/23.
//  Copyright © 2017年 乔现宁. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DownloaderOperation.h"

@interface DownloaderOperationManager : NSObject

/// 单例全局访问点
+ (instancetype)sharedManager;

/**
 单例管理下载的主方法

 @param urlStr 下载地址
 @param finishedBlock 下载完成之后的回调
 */
- (void)downloadImageWithUrlStr:(NSString *)urlStr finished:(void (^)(UIImage *image))finishedBlock;

@end
