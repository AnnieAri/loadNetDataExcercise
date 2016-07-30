//
//  ARDownloadOperation.m
//  NetWorkDemoExercise
//
//  Created by Ari on 16/7/30.
//  Copyright © 2016年 com.Ari. All rights reserved.
//

#import "ARDownloadOperation.h"
#import "NSString+path.h"

@interface ARDownloadOperation ()
@property (nonatomic, copy) NSString *urlString;
@end
@implementation ARDownloadOperation
+ (instancetype)operationWithUrlString:(NSString *)urlString{
    /**
     初始化一个实例变量
     
     - author: Ari
     
     - returns:
     */
    ARDownloadOperation *op = [[self alloc] init];
    //记录urlString
    op.urlString = urlString;
    return op;
}
- (void)main{
    //系统会自动执行操作的main   操作代码写在main里面
    //获得图片的url
    NSURL *imageURL = [NSURL URLWithString:self.urlString];
    //转换成2进制数据
    NSData *data = [NSData dataWithContentsOfURL:imageURL];
    //2进制数据转化为图片
    UIImage *image = [UIImage imageWithData:data];
    //数据存入沙盒一份
    [data writeToFile:[_urlString appendCachePath] atomically:true];
    
    self.image = image;
    
    
}

@end
