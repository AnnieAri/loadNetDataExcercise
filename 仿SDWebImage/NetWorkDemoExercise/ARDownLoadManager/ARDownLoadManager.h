//
//  ARDownLoadManager.h
//  NetWorkDemoExercise
//
//  Created by Ari on 16/7/30.
//  Copyright © 2016年 com.Ari. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ARDownLoadManager : NSObject
/**
 *  @author Ari
 *
 *  単例创建
 *
 *  @return 単例对象
 */
+ (instancetype)sharedManager;


- (void)downloadImageWithUrlString:(NSString *)urlString compeletion:(void(^)(UIImage *))compeletion;

@end
