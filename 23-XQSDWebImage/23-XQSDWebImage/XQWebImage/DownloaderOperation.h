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

/// 接受外界传入的图片地址
@property(nonatomic,copy)   NSString    * urlString;

/// B2. 接收外界传入的代码块
@property(nonatomic,copy)   void(^finishedBlock)(UIImage *);

@end
