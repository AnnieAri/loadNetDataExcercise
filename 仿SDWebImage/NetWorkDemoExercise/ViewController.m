//
//  ViewController.m
//  NetWorkDemoExercise
//
//  Created by Ari on 16/7/29.
//  Copyright © 2016年 com.Ari. All rights reserved.
//

#import "ViewController.h"
#import "AppInfo.h"
#import "AFNetworking.h"
//#import "UIImageView+WebCache.h"
#import "AppCell.h"
#import "ARDownLoadManager.h"
#define kCachesPath NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask,true).lastObject
@interface ViewController ()
/**
 *  @author Ari
 *
 *  数据模型
 */
@property (nonatomic,strong) NSMutableArray<AppInfo *> *appInfos;
///**
// *  @author Ari
// *
// *  操作队列   因为cell的复用机制  避免多次创建队列  故使用全局变量
// */
//@property (nonatomic,strong) NSOperationQueue *queue;
///**
// *  @author Ari
// *
// *  图片缓存
// */
//@property (nonatomic,strong) NSMutableDictionary *imageCache;
///**
// *  @author Ari
// *
// *  操作缓存
// */
//@property (nonatomic,strong) NSMutableDictionary *operationCache;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];

    
}
#pragma mark - tableView数据源设置
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.appInfos.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AppCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    //获取该IndexPath下的模型
    //因为cell的复用的原因 设置cell的占位图片为nil
    cell.iconView.image = nil;
    AppInfo *appInfo =self.appInfos[indexPath.row];
    cell.nameLabel.text = appInfo.name;
    cell.downLoadLabel.text = appInfo.download;
    [[ARDownLoadManager sharedManager] downloadImageWithUrlString:appInfo.icon compeletion:^(UIImage *image) {
        cell.iconView.image = image;
    }];
   
    return cell;
}
/**
 //判断内存中是否有该Indexcell 的图片  如果有直接从内存中取值 给图片赋值
 UIImage *cacheImage = self.imageCache[appInfo.icon];
 if (cacheImage) {
 NSLog(@"从内存中获取图片!");
 cell.iconView.image =cacheImage;
 return cell;
 }
 //判断沙盒中是否有该图片
 cacheImage = [UIImage imageWithContentsOfFile:[kCachesPath stringByAppendingPathComponent:appInfo.icon.lastPathComponent]];
 if (cacheImage) {
 NSLog(@"从沙盒中取出图片");
 cell.iconView.image = cacheImage;
 [self.imageCache setObject:cacheImage forKey:appInfo.icon];
 return cell;
 }
 //判断 当前cell的图片是否已经在下载中  如果在下载 提示 正在下载;
 if (self.operationCache[appInfo.icon]){
 NSLog(@"图标正在下载中  不要着急!!");
 return cell;
 }
 //从网络中获取app的icon
 //创建一个从网络下载图片的操作
 NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
 [NSThread sleepForTimeInterval:3];
 NSLog(@"网络下载图片!");
 NSURL *url = [NSURL URLWithString:appInfo.icon];
 NSData *data = [NSData dataWithContentsOfURL:url];
 UIImage *image = [UIImage imageWithData:data];
 //保存图片到沙盒
 [data writeToFile:[kCachesPath stringByAppendingPathComponent:appInfo.icon.lastPathComponent] atomically:true];
 [[NSOperationQueue mainQueue] addOperationWithBlock:^{
 NSLog(@"图片下载完成");
 //如果image有值 就存入图片缓存字典中
 if (image) {
 [self.imageCache setObject:image forKey:appInfo.icon];
 }
 
 // 回到主线程更新UI
 // cell.iconView.image = image;
 // 先更改数据: 将下载回来的图片与模型进行一一对应,不能直接在这个地方更改cell,因为图片下载完成之后,cell里面显示的模型可能已经不是之前显示的模型的内容了.
 
 //下载完成 要从操作缓存中移除该操作
 [self.operationCache removeObjectForKey:appInfo.icon];
 // 再刷新模型对应的cell
 // reloadRowsAtIndexPaths : 刷新对应 indexPath 行的数据
 //            NSLog(@"%ld",indexPath.row);
 // 这个方法会调用 返回cell的方法,并且只会刷新对应 indexPath 的行,传对应的indexpath就会刷新(重新加载)对应的cell
 //等图片下载完毕 会重新刷新原来没有图片的cell
 [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
 
 }];
 
 }];
 
 [self.queue addOperation:op];
 
 //将操作加入到操作缓存中  避免重复下载图片
 [self.operationCache setObject:op forKey:appInfo.icon];

 */

/**
 *  @author Ari
 *
 *  接受到内存警告 需要进行的操作!!
 */
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    
//    [self.imageCache removeAllObjects];
}


#pragma mark - 获取网络数据
- (void)loadData{
    /**
     *  @author Ari
     *
     *  Jason网址
     */
    NSString *urlString = @"https://raw.githubusercontent.com/yinqiaoyin/SimpleDemo/master/apps.json";
    
    //初始化一个网络请求管理器
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *array = responseObject;
       //字典转模型
        for (NSDictionary *dict in array) {
            [self.appInfos addObject:[AppInfo appInfoWithDict:dict]];
        }
        //数据获取完成 刷新tableView
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"加载失败");
    }];
    
}

//- (NSMutableDictionary *)operationCache{
//    if (!_operationCache) {
//        _operationCache =[NSMutableDictionary dictionary];
//    }
//    return _operationCache;
//}
///**
// *  @author Ari
// *
// *  懒加载 创建图片缓存字典
// */
//- (NSMutableDictionary *)imageCache{
//    if (!_imageCache) {
//        _imageCache = [NSMutableDictionary dictionary];
//    }
//    return _imageCache;
//}
/**
 *  @author Ari
 *
 *  懒加载 appInfos
 *
 */
- (NSMutableArray<AppInfo *> *)appInfos{
    if (!_appInfos) {
        _appInfos = [NSMutableArray array];
    }
    return _appInfos;
}
///**
// *  @author Ari
// *
// *  懒加载创建一个队列
// *
// */
//- (NSOperationQueue *)queue{
//    if (!_queue) {
//        _queue = [[NSOperationQueue alloc] init];
//    }
//    return _queue;
//}
@end
