//
//  PlayerView.h
//  Download
//
//  Created by Yang on 2017/8/1.
//  Copyright © 2017年 A589. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayerView : UIView
@property (weak, nonatomic) IBOutlet UIButton *fullScreenBtn;
- (IBAction)backBtnClick:(UIButton *)sender;
- (IBAction)fullScreenBtnClick:(UIButton *)sender;
@property(nonatomic,strong)NSString *path;

-(void)playWith:(NSString *)path;

@property(nonatomic,strong)void(^backBtnClick)(void);
@end
