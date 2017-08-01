//
//  FileModel.h
//  Download
//
//  Created by Yang on 2017/7/31.
//  Copyright © 2017年 A589. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DownloadManager.h"

@interface FileModel : NSObject
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *playUrl;

/** 下载状态 */
@property (nonatomic, assign) TaskDownloadStatus downloadStatus;
@end
