//
//  ViewController.m
//  Download
//
//  Created by Yang on 2017/7/31.
//  Copyright © 2017年 A589. All rights reserved.
//

#import "ViewController.h"
#import "DownloadCell.h"
#import "FileModel.h"
#import "TaskProgressInfo.h"
#import "DownloadManager.h"
#import <MediaPlayer/MediaPlayer.h>
#import "VideoViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *table;
@property(nonatomic,strong)NSMutableArray *mutableArray;
@end

@implementation ViewController
-(NSMutableArray *)mutableArray{
    if (!_mutableArray) {
        _mutableArray = [NSMutableArray array];
    }
    return _mutableArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    self.table.delegate = self;
    self.table.dataSource = self;
    NSLog(@"%@",[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]);
}


-(void)loadData{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"videoData.json" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray *allVideo = rootDict[@"videoList"];
    for (NSDictionary *dic in allVideo) {
        FileModel *file = [[FileModel alloc] init];
        file.title = dic[@"title"];
        file.playUrl = dic[@"playUrl"];
        [self.mutableArray addObject:file];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.mutableArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DownloadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DownloadCell"];
    [cell downloadWith:self.mutableArray[indexPath.row]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FileModel *file = self.mutableArray[indexPath.row];
    TaskProgressInfo *info = [[DownloadManager shareManager] progressInfoIfFileExsit:file.playUrl];
    NSLog(@"%@",info.path);
    VideoViewController *vc = [[VideoViewController alloc] init];
    vc.path = info.path;
    [self presentViewController:vc animated:YES completion:nil
     ];
}
@end
