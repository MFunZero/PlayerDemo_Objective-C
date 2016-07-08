//
//  BannerScrollView.m
//  PlayerDemo_Objective-C
//
//  Created by fanzz on 16/7/7.
//  Copyright © 2016年 fanzz. All rights reserved.
//

#import "BannerScrollView.h"
#import "UIImageView+WebCache.h"


@interface BannerScrollView()<UIScrollViewDelegate>

@property (nonatomic,copy) NSArray<UIImageView *>* imgViews;
@property (nonatomic,copy) UIPageControl * pageControll;
@property (nonatomic,strong) NSTimer * timer;
@property  BOOL isFirst;
@end


@implementation BannerScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 
 */

- (void)setImgsList:(NSArray<ListItemModel *> *)imgsList {
    _imgsList = imgsList;
    
    self.delegate = self;
    _isFirst = true;
    double width = ScreenW;
    
    for (int i = 0; i < _imgsList.count; i++) {
        
        CGRect rect = CGRectMake(i*width, 0.0, width, BannerHeight);
        UIImageView * imgV = [[UIImageView alloc]initWithFrame:rect];
        [_imgViews arrayByAddingObject:imgV];
        NSURL * url = [NSURL URLWithString:_imgsList[i].img];
        [imgV sd_setImageWithURL:url];
        [self addSubview:imgV];
    }
    
    self.contentSize = CGSizeMake(_imgsList.count * width, 0);
    
    self.showsHorizontalScrollIndicator = NO;
    self.pagingEnabled = YES;
    self.delegate = self;
    
    _pageControll = [[UIPageControl alloc]initWithFrame:CGRectMake(width/2-40, BannerHeight - 40, 80, 40)];
    [self.superview addSubview:_pageControll];
    
    _pageControll.pageIndicatorTintColor = [UIColor cyanColor];
    _pageControll.numberOfPages = imgsList.count;
    _pageControll.currentPage = 0;
    _pageControll.currentPageIndicatorTintColor = [UIColor redColor];
    
    [self addTimer];

}


- (void)drawRect:(CGRect)rect {
    
}

- (void) addTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
}

- (void)nextPage{
    
    int page = (int)self.pageControll.currentPage;
    if (page == _imgsList.count) {
        page = 0;
    }else {
        page ++;
    }
}

- (void) removeTimer {
    [self.timer invalidate];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    int page = scrollView.contentOffset.x / ScreenW;
    _pageControll.currentPage = page;
    
   
   
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
//    [self removeTimer];
   
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self addTimer];
}

@end
