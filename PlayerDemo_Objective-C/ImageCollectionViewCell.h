//
//  ImageCollectionViewCell.h
//  PlayerDemo_Objective-C
//
//  Created by fanzz on 16/7/7.
//  Copyright © 2016年 fanzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageVIew;

@property (nonatomic,copy) NSString * imgURL;

@end