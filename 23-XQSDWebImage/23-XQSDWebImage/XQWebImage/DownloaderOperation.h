//
//  DownloaderOperation.h
//  23-XQSDWebImage
//
//  Created by sdos on 2017/8/18.
//  Copyright © 2017年 乔现宁. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DownloaderOperation : NSOperation

/* 
 类方法已经将这两个属性暴露出去  因此将其改为私有的
 */
/// 接受外界传入的图片地址
//@property(nonatomic,copy)   NSString    * urlString;
//
///// B2. 接收外界传入的代码块
//@property(nonatomic,copy)   void(^finishedBlock)(UIImage *);


/**
 实例化自定义操作的类方法

 @param urlString 图片地址
 @param finishedBlock 下载完成之后的回调
 @return 实例
 */
+ (instancetype)downloaderOperationWithUrlString:(NSString *)urlString finished:(void(^)(UIImage *image))finishedBlock;

@end
