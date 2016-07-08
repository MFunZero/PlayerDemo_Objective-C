//
//  SuzeeCollectionViewLayout.h
//  PlayerDemo_Objective-C
//
//  Created by fanzz on 16/7/5.
//  Copyright © 2016年 fanzz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SuzeeCollectionViewLayout;

@protocol SuzeeCollectionViewLayoutDelegate <NSObject>

- (CGFloat)flowLayout:(SuzeeCollectionViewLayout *)flowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath;

@end

@interface SuzeeCollectionViewLayout : UICollectionViewLayout

/** 列间距 */
@property(nonatomic,assign)CGFloat columnMargin;
/** 行间距 */
@property(nonatomic,assign)CGFloat rowMargin;
/** 列数 */
@property(nonatomic,assign)int columnsCount;
/** 外边距 */
@property (nonatomic, assign) UIEdgeInsets sectionInset;
@property (nonatomic, weak) id<SuzeeCollectionViewLayoutDelegate> delegate;

@end
