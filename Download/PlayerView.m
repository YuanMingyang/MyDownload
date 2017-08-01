//
//  PlayerView.m
//  Download
//
//  Created by Yang on 2017/8/1.
//  Copyright © 2017年 A589. All rights reserved.
//

#import "PlayerView.h"
#import <AVFoundation/AVFoundation.h>
@interface PlayerView ()
@property(nonatomic,strong)AVPlayer *player;
@property(nonatomic,strong)AVPlayerLayer *playerLayer;

@property(nonatomic,assign)CGRect oldFrame;
@end
@implementation PlayerView



-(void)playWith:(NSString *)path{
    
    NSString *path1 = [[NSBundle mainBundle] pathForResource:@"2BF06A944C9D7EB40836D89595999231.mp4" ofType:nil];
    
    self.player = [AVPlayer playerWithURL:[NSURL fileURLWithPath:path]];
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    self.playerLayer.frame = self.bounds;
    self.oldFrame = self.bounds;
    [self.layer insertSublayer:self.playerLayer atIndex:0];
    [self.player play];
}
- (IBAction)backBtnClick:(UIButton *)sender {
    if (self.fullScreenBtn.selected) {
        NSLog(@"===%@",NSStringFromCGRect(self.oldFrame));
        [UIView animateWithDuration:0.2 animations:^{
            [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationPortrait] forKey:@"orientation"];
            self.frame = self.oldFrame;
        }];
        self.fullScreenBtn.selected = NO;
    }else{
        [self.player pause];
        self.player = nil;
        self.playerLayer = nil;
        self.backBtnClick();
    }

}

- (IBAction)fullScreenBtnClick:(UIButton *)sender {

    if (!sender.selected) {
        [UIView animateWithDuration:0.2 animations:^{
            [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationLandscapeLeft] forKey:@"orientation"];
            self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        }];
    }else{
        [UIView animateWithDuration:0.2 animations:^{
            [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationPortrait] forKey:@"orientation"];
            self.frame = self.oldFrame;
        }];
    }
    
    sender.selected = !sender.selected;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    /** 当视频横向时 重新设置playerlayer的frame */
    self.playerLayer.frame = self.bounds;
}
@end
