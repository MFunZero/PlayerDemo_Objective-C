//
//  SingleAlbumModel.h
//  PlayerDemo_Objective-C
//
//  Created by fanzz on 16/7/7.
//  Copyright © 2016年 fanzz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingleAlbumModel : NSObject


@property (nonatomic,copy) NSString * id;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * count;
@property (nonatomic,copy) NSString * categery;
@property (nonatomic,copy) NSArray  * covers;
@property (nonatomic,copy) NSString * status;
@property (nonatomic,copy) NSString * like_count;
@property (nonatomic,copy) NSString * actived_at;
@property (nonatomic,copy) NSString * favorite_count;
@property (nonatomic,copy) NSString * favorite_id;

@end
