//
//  VideoViewController.m
//  Download
//
//  Created by Yang on 2017/8/1.
//  Copyright © 2017年 A589. All rights reserved.
//

#import "VideoViewController.h"
#import "PlayerView.h"
#import <AVFoundation/AVFoundation.h>
@interface VideoViewController ()
@property(nonatomic,strong)AVPlayer *player;
@property(nonatomic,strong)AVPlayerLayer *playerLayer;
@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    PlayerView *player = [[NSBundle mainBundle] loadNibNamed:@"PlayerView" owner:nil options:nil].firstObject;
    player.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 220);
    player.path = self.path;
    [player playWith:self.path];
    __weak typeof(self)weakSelf = self;
    player.backBtnClick = ^(){
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    };
    [self.view addSubview:player];

}

-(void)backBtnClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
