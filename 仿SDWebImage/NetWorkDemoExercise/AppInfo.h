//
//  AppInfo.h
//  NetWorkDemoExercise
//
//  Created by Ari on 16/7/29.
//  Copyright © 2016年 com.Ari. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppInfo : NSObject

/**
 *  @author Ari
 *
 *  应用名字
 */
@property (nonatomic, copy) NSString *name;
/**
 *  @author Ari
 *
 *  应用下载数量
 */
@property (nonatomic, copy) NSString *download;
/**
 *  @author Ari
 *
 *  应用图标url
 */
@property (nonatomic, copy) NSString *icon;

+ (instancetype)appInfoWithDict:(NSDictionary *)dict;

@end


