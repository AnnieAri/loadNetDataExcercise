//
//  ARDownloadOperation.m
//  NetWorkDemoExercise
//
//  Created by Ari on 16/7/30.
//  Copyright © 2016年 com.Ari. All rights reserved.
//

#import "ARDownloadOperation.h"

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
}

@end
