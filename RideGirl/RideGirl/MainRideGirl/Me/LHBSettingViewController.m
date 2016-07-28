//
//  LHBSettingViewController.m
//  RideGirl
//
//  Created by LHB on 16/7/28.
//  Copyright © 2016年 LHB. All rights reserved.
//

#import "LHBSettingViewController.h"
#import <SDWebImage/SDImageCache.h>

@interface LHBSettingViewController ()

@end

@implementation LHBSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"设置";
    
  
}

- (void)getSize
{
    //图片缓存
    //    1、第一种方法，依赖SDWebImage框架，可以看看SDWebImage getSize的写法
    NSUInteger size = [[SDImageCache sharedImageCache] getSize];
    LHBLog(@"sd的方法：%ld",size);
    //    LHBLog(@"%@",NSHomeDirectory());
    
    //    2、第二种方法
    NSFileManager *manager = [NSFileManager defaultManager];
    //SDWebImage的缓存路径
    NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *path = [cachPath stringByAppendingPathComponent:@"default/com.hackemist.SDWebImageCache.default"];
    
    //给manager一个路径，来获取属性，属性里包括文件大小属性
    //这个获取的文件夹及文件夹内部的子文件是不准的，要获取每一个文件的大小，并累加才准确
    //    NSDictionary *dic = [manager attributesOfItemAtPath:path error:nil];
    
    //文件遍历器
    NSDirectoryEnumerator *fileEnumerator = [[NSFileManager defaultManager] enumeratorAtPath:path];
    NSInteger totalFileSize = 0;
    for (NSString *fileName in fileEnumerator) {//文件名
        //文件全路径
        NSString *filePath = [cachPath stringByAppendingPathComponent:fileName];
        
        //第一种方法判断该路径是不是文件夹
        //因为文件夹大小不准，所以要判断路径是否是文件夹，是的话，跳过
        BOOL isDir = NO;
        //传一个路径，判断是不是文件夹，如果是文件夹，给isDir赋值为YES
        [manager fileExistsAtPath:filePath isDirectory:&isDir];
        if (isDir)    continue;
        
        
        //文件属性
        NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        
        //第二种方法判断路径是否是文件夹
        // if ([attrs[NSFileType] isEqualToString:NSFileTypeDirectory]) continue;
        
        
        NSInteger size =[attrs[NSFileSize] integerValue];
        totalFileSize += size;
    }
    
    LHBLog(@"我计算%zd",totalFileSize);
}
- (void)getSize2
{
    NSFileManager *manager = [NSFileManager defaultManager];
    //SDWebImage的缓存路径
    NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *path = [cachPath stringByAppendingPathComponent:@"default/com.hackemist.SDWebImageCache.default"];
    
    //    获取文件夹内部所有的内容
    //    NSArray *contents = [manager contentsOfDirectoryAtPath:cachPath error:nil];
    
    NSArray *subPaths = [manager subpathsAtPath:cachPath];
    NSLog(@"subPaths:%@",subPaths);
    

}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    CGFloat size = [[SDImageCache sharedImageCache] getSize]/1000.0/1000;
    
    cell.textLabel.text = [NSString stringWithFormat:@"清除缓存,(已使用%.2fM)",size];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //清缓存
    //1、如果是清除某个文件夹的缓存，一删除这个文件夹就可以了
    //[[NSFileManager defaultManager] removeItemAtPath:nil error:nil];
    
    //2、如果是SDWebImage的话，更简单
    [[SDImageCache sharedImageCache] clearDisk];
    
    [self.tableView reloadData];
}


@end
