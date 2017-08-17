//
//  ViewController.m
//  23-XQSDWebImage
//
//  Created by sdos on 2017/8/18.
//  Copyright © 2017年 乔现宁. All rights reserved.
//

#import "ViewController.h"
#import "DownloaderOperation.h"
#import "AFNetworking.h"
#import "APPModel.h"
#import "YYModel.h"

@interface ViewController ()

/// 全局并发队列
@property(nonatomic,strong)   NSOperationQueue    * queue;
/// 数据源数组
@property(nonatomic,strong)   NSArray    * dataSourceArr;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建队列
    self.queue = [[NSOperationQueue alloc] init];
    
    // 没有实际意义 测试自定义操作是否可行 为了提供数据 有了数据再点击屏幕
    [self loadData];
}


/// 获取json数据的主方法
- (void)loadData{
    NSString *urlStr = @"https://raw.githubusercontent.com/qxnsdos/XQ11/master/apps.json";
        
    //获取json数据
    [[AFHTTPSessionManager manager] GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.dataSourceArr = [NSArray yy_modelArrayWithClass:[APPModel class] json:responseObject];
        NSLog(@"%@",self.dataSourceArr);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

// 需求 : 点击屏幕时使用 DownloaderOperation 随机下载网络图片
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    // 生成随机数
    int random = arc4random_uniform((uint32_t)self.dataSourceArr.count);
    
    // 通过随机数随机获取图片地址(模型)
    APPModel *app = self.dataSourceArr[random];
    
    // 把随机图片地址传入 DownloaderOperation
    DownloaderOperation *op = [DownloaderOperation downloaderOperationWithUrlString:app.icon finished:^(UIImage *image) {
//        NSLog(@"%@  %@",image,[NSThread currentThread]);
        
        // 刷新UI
        self.iconImageView.image = image;
    }];
    
    // 把操作添加到队列
    [self.queue addOperation:op];
}









/*
- (void)test{
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
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
