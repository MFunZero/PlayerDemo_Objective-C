//
//  ImageCollectionViewCell.m
//  PlayerDemo_Objective-C
//
//  Created by fanzz on 16/7/7.
//  Copyright © 2016年 fanzz. All rights reserved.
//

#import "ImageCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "AFNetWorking.h"

@interface ImageCollectionViewCell()


@end




@implementation ImageCollectionViewCell

- (void)setImgURL:(NSString *)imgURL{
   
    NSArray * strs = [imgURL componentsSeparatedByString:@"_webp"];
    _imgURL = strs[0];
    NSURL * url = [NSURL URLWithString:_imgURL];
    NSData * data = [NSData dataWithContentsOfURL:url];
    UIImage * img = [UIImage imageWithData:data];
        if (img != nil) {
//    [self.imageVIew setImage:img];
            
        }
//    _imageVIew.backgroundColor = [UIColor brownColor];
    
    
    [_imageVIew sd_setImageWithURL:url];
     _imageVIew.contentMode = UIViewContentModeScaleAspectFit;

    
    
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    if (mgr.isReachableViaWiFi)     { // 在使用Wifi, 下载原图
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        
        [manager downloadImageWithURL:url options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            NSLog(@"显示当前进度%ld",receivedSize / expectedSize);
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            NSLog(@"下载完成");
        }];
    } else if (mgr.isReachableViaWWAN) {//在使用手机自带网络时
        
    }else { // 其他，下载小图
        
    }
    
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
