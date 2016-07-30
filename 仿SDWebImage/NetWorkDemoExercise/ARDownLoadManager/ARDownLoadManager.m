//
//  ARDownLoadManager.m
//  NetWorkDemoExercise
//
//  Created by Ari on 16/7/30.
//  Copyright © 2016年 com.Ari. All rights reserved.
//

#import "ARDownLoadManager.h"

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
        
    }
    return self;
}

- (void)downloadImageWithUrlString:(NSString *)urlString compeletion:(void(^)(UIImage *))compeletion{
    
}
@end
