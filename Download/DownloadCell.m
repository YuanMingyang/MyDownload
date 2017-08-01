//
//  DownloadCell.m
//  Download
//
//  Created by Yang on 2017/7/31.
//  Copyright © 2017年 A589. All rights reserved.
//

#import "DownloadCell.h"
#import "DownloadManager.h"

@interface DownloadCell()
@property(nonatomic,assign)BOOL waitDownload;
@end

@implementation DownloadCell
- (void)layoutSubviews{
    [super layoutSubviews];
    if (self.waitDownload) {
        [self.downloadBtn setTitle:@"等待" forState:UIControlStateNormal];
    }
    if (self.progressView.progress==1) {
        [self.downloadBtn setTitle:@"完成" forState:UIControlStateNormal];
    }
}
-(void)downloadWith:(FileModel *)file{
    _file = file;
    self.titleLabel.text = file.title;
    if (self.waitDownload==YES) {
        [self.downloadBtn setTitle:@"等待" forState:UIControlStateNormal];
    }
    TaskProgressInfo *info = [[DownloadManager shareManager] progressInfoIfFileExsit:file.playUrl];
    __weak typeof(self)ws = self;
    if (info) {
        if (info.progress==1) {
            self.file.downloadStatus = TaskHasDownload;
            self.progressView.progress = 1;
        }else{
            self.progressView.progress = info.progress;
            self.file.downloadStatus = info.taskDownloadStatus;
            if (info.taskDownloadStatus!=TaskNotDownload) {
                [ws start];
            }
        }
    }else{
        self.file.downloadStatus = TaskNotDownload;
        self.progressView.progress = info.progress;
    }
    [self setButtonTitle];
}


-(void)setButtonTitle{
    switch (self.file.downloadStatus) {
        case TaskIsDownloading:{
            [self.downloadBtn setTitle:@"暂停" forState:UIControlStateNormal];
            break;
        }
        case TaskWaitDownload:{
            [self.downloadBtn setTitle:@"等待" forState:UIControlStateNormal];
            break;
        }
        case TaskHasDownload:{
            [self.downloadBtn setTitle:@"完成" forState:UIControlStateNormal];
            break;
        }
        case TaskResumeDownload:{
            [self.downloadBtn setTitle:@"暂停" forState:UIControlStateNormal];
            break;
        }
        case TaskNotDownload:{
            [self.downloadBtn setTitle:@"下载" forState:UIControlStateNormal];
            break;
        }
        default:{
            break;
        }
    }
}
/**
 *  恢复（继续）
 */
- (void)resume{
    [self.downloadBtn setTitle:@"暂停" forState:UIControlStateNormal];
    [[DownloadManager shareManager] retryDownload:self.file.playUrl];
}
/**
 *  暂停
 */
- (void)pause
{
    [self.downloadBtn setTitle:@"下载" forState:UIControlStateNormal];
    [[DownloadManager shareManager] cancleDownload:self.file.playUrl];
    self.file.downloadStatus = TaskNotDownload;
}
/**
 *  从零开始
 */
- (void)start
{

    
    [self.downloadBtn setTitle:@"暂停" forState:UIControlStateNormal];
    __weak typeof(self)ws = self;

    [[DownloadManager shareManager] download:self.file.playUrl progress:^(TaskProgressInfo *progressInfo) {
        if (!ws.file.playUrl) {
            return ;
        }
        if ([self.file.playUrl isEqualToString:progressInfo.url]) {
            ws.progressView.progress = progressInfo.progress;
            ws.file.downloadStatus = progressInfo.taskDownloadStatus;
        }
        [ws setButtonTitle];
    } complete:^(NSString *filePath, NSError *error) {
        
    } enableBackgroundMode:YES];
    TaskProgressInfo *info = [[DownloadManager shareManager] progressInfoIfFileExsit:self.file.playUrl];
    self.progressView.progress = info.progress;
}



- (IBAction)downloadBtnClick:(UIButton *)sender {
    switch (self.file.downloadStatus) {
        case TaskHasDownload:{
            //下载完成
            break;
        }
        case TaskResumeDownload:{
            [self resume];
            break;
        }
        case TaskNotDownload:{
            
            [self start];
            break;
        }
        case TaskIsDownloading:{
            [self pause];
            break;
        }
        case TaskWaitDownload:{
            [self.downloadBtn setTitle:@"等待" forState:UIControlStateNormal];
            break;
        }
        default:
            break;
    }
}
@end
