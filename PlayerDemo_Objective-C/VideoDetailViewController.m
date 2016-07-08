//
//  VideoDetailViewController.m
//  PlayerDemo_Objective-C
//
//  Created by fanzz on 16/7/7.
//  Copyright © 2016年 fanzz. All rights reserved.
//

#import "VideoDetailViewController.h"
#import "ZFPlayer.h"
#import "ZFPlayerView.h"

#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>


@interface VideoDetailViewController ()
@property (weak, nonatomic) IBOutlet ZFPlayerView * playerView;

@end

@implementation VideoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.playerView.videoURL = [NSURL URLWithString:@"http://www.bilibilijj.com/Files/DownLoad/4466.mp4/www.bilibilijj.com.mp4?mp3=true"];
    self.playerView.playerLayerGravity = ZFPlayerLayerGravityResizeAspect;
    //打开断点下载功能(默认没有这个功能)
    self.playerView.hasDownload = YES;
    
    // 如果想从xx秒开始播放视频
    // self.playerView.seekTime = 15;
    
    //是否自动播放, 默认不自动播放
//    [self.playerView autoPlayTheVideo];



    __weak typeof(self) weakSelf = self;
    self.playerView.goBackBlock = ^{
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
