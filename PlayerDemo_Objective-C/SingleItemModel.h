//
//  SingleItemModel.h
//  PlayerDemo_Objective-C
//
//  Created by fanzz on 16/7/7.
//  Copyright © 2016年 fanzz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SingleAlbumModel.h"

@interface SingleItemModel : NSObject


@property (nonatomic,copy) NSDictionary *album;
@property (nonatomic,copy) NSDictionary * photo;
@property (nonatomic,copy) NSString * msg;
@property (nonatomic,copy) NSString * id;
@property (nonatomic,copy) NSDictionary * sender;
@property (nonatomic,copy) NSString * buyable;
@property (nonatomic,copy) NSString * reply_count;
@property (nonatomic,copy) NSString * icon_url;
@property (nonatomic,copy) NSString * sender_id;
@property (nonatomic,copy) NSString * like_count;
@property (nonatomic,copy) NSString * favorite_count;
@property (nonatomic,copy) NSString * extra_type;



@end
