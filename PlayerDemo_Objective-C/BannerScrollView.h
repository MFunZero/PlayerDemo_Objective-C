//
//  BannerScrollView.h
//  PlayerDemo_Objective-C
//
//  Created by fanzz on 16/7/7.
//  Copyright © 2016年 fanzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListItemModel.h"


@interface BannerScrollView : UIScrollView

@property (copy,nonatomic) NSArray<ListItemModel *> * imgsList;

@end
