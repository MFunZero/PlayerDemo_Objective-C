//
//  URLItem.h
//  PlayerDemo_Objective-C
//
//  Created by fanzz on 16/7/5.
//  Copyright © 2016年 fanzz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SingleItemModel.h"
@interface URLItem : NSObject


@property (nonatomic,copy) NSString * total;
@property (nonatomic,copy) NSString * more;
@property (nonatomic,copy) NSString * next_start;
@property (nonatomic,copy) NSArray<SingleItemModel *> * object_list;



@end
