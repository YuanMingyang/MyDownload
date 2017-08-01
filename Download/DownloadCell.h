//
//  DownloadCell.h
//  Download
//
//  Created by Yang on 2017/7/31.
//  Copyright © 2017年 A589. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FileModel.h"

@interface DownloadCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *downloadBtn;

- (IBAction)downloadBtnClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property(nonatomic,strong)FileModel *file;

-(void)downloadWith:(FileModel *)file;
@end
