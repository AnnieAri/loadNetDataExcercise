//
//  ARDownloadOperation.h
//  NetWorkDemoExercise
//
//  Created by Ari on 16/7/30.
//  Copyright © 2016年 com.Ari. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ARDownloadOperation : NSOperation
/**
 *  @author Ari
 *
 *  类方法 通过urlString创建一个操作实例
 *
 *  @param urlString <#urlString description#>
 *
 *  @return <#return value description#>
 */
+ (instancetype)operationWithUrlString:(NSString *)urlString;
@end
