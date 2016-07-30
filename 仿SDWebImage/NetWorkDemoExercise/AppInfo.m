//
//  AppInfo.m
//  NetWorkDemoExercise
//
//  Created by Ari on 16/7/29.
//  Copyright © 2016年 com.Ari. All rights reserved.
//

#import "AppInfo.h"

@implementation AppInfo : NSObject 
+ (instancetype)appInfoWithDict:(NSDictionary *)dict{
    AppInfo *appInfo = [[self alloc] init];
    [appInfo setValuesForKeysWithDictionary:dict];
    return appInfo;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end




