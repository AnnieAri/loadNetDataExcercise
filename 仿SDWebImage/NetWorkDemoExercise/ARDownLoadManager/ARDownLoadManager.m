//
//  ARDownLoadManager.m
//  NetWorkDemoExercise
//
//  Created by Ari on 16/7/30.
//  Copyright © 2016年 com.Ari. All rights reserved.
//

#import "ARDownLoadManager.h"
#import "NSString+path.h"

@interface ARDownLoadManager ()
/**
 *  @author Ari
 *
 *  图片缓存
 */
@property (nonatomic,strong) NSMutableDictionary *imageCache;
/**
 *  @author Ari
 *
 *  操作缓存
 */
@property (nonatomic,strong) NSMutableDictionary *operationCache;
@end
@implementation ARDownLoadManager
+ (instancetype)sharedManager{
    static ARDownLoadManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        /**
         *  @author Ari
         *
         *  初始化两个缓存
         */
        self.imageCache = [NSMutableDictionary dictionary];
        self.operationCache =[NSMutableDictionary dictionary];
        
    }
    return self;
}

- (void)downloadImageWithUrlString:(NSString *)urlString compeletion:(void(^)(UIImage *))compeletion{
    //1.先判断内存中是否有这个图片对象
    UIImage *image = self.imageCache[urlString];
    if (image) {
        NSLog(@"从内存中取");
        //直接用block 进行回调
        compeletion(image);
        return;
    }
    //2.判断沙盒中是否存在这个图片
    //2.1获取沙盒中文件的路径
    NSString *imagePath = [urlString appendCachePath];
    image = [UIImage imageWithContentsOfFile:imagePath];
    if (image) {
        NSLog(@"从沙盒中取");
        //2.2直接用block回调
        compeletion(image);
        //2.3存到内存中一份 以便下次直接在内存中加载
        [self.imageCache setObject:image forKey:urlString];
        return;
    }
    //3.判断操作是否已经存在
    if (self.operationCache[urlString]) {
        NSLog(@"图片正在下载中,请稍等!!");
        return;
    }
    //4.创建操作下载图片
    NSLog(@"创建操作 下载图片");
    
    
    
}
@end
