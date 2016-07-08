
//
//  VideoCollectionViewController.m
//  PlayerDemo_Objective-C
//
//  Created by fanzz on 16/7/7.
//  Copyright © 2016年 fanzz. All rights reserved.
//

#import "VideoCollectionViewController.h"
#import "SuzeeCollectionViewLayout.h"
#import "AFNetWorking.h"
#import "MJExtension.h"
#import "ImageCollectionViewCell.h"
#import "BannerScrollView.h"
#import "VideoItemModel.h"
#import "EndsItem.h"
#import "ListItemModel.h"
#import "VideoDetailViewController.h"

@interface VideoCollectionViewController ()<SuzeeCollectionViewLayoutDelegate>

@property (nonatomic,strong) AFHTTPSessionManager * mgr;
@property (nonatomic,strong) BannerScrollView * bannerView;
@property (nonatomic,strong) NSMutableArray * contentArray;
@property (nonatomic,strong) NSMutableArray * bannerArray;


@end

@implementation VideoCollectionViewController

static NSString * const reuseIdentifier = @"Cell";


- (AFHTTPSessionManager *)mgr {
    if (!_mgr) {
        self.mgr = [[AFHTTPSessionManager alloc] init];
    }
    return  _mgr;
}

- (NSMutableArray *)contentArray {
    if (!_contentArray){
        self.contentArray = [[NSMutableArray alloc]init];
    }
    return _contentArray;
}

- (NSMutableArray *)bannerArray {
    if (!_bannerArray) {
        self.bannerArray = [[NSMutableArray alloc]init];
    }
    return  _bannerArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self requestData];

    self.collectionView.contentInset = UIEdgeInsetsMake(BannerHeight, 0, 0, 0);
    
    
    
    
    SuzeeCollectionViewLayout * layoutNew = [[SuzeeCollectionViewLayout alloc]init];
    layoutNew.delegate = self;
    self.collectionView.collectionViewLayout = layoutNew;
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(ImageCollectionViewCell.self) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    
    
    _bannerView = [[BannerScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, BannerHeight)];
    [self.view addSubview:_bannerView];
    _bannerView.backgroundColor = [UIColor whiteColor];
    
    // Do any additional setup after loading the view.
}

- (void) requestData {
    
    [self.mgr GET:@"http://bangumi.bilibili.com/api/app_index_page_v2?access_key=20819ee9177d90bd7b07ca20b6bd6727&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3360&device=phone&platform=ios&sign=8b2717cac07eae922f8302eeefe7212a&ts=1465654494" parameters:@"" progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"progress:%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"Success%@",responseObject);
        if ([responseObject[@"message"] isEqualToString: @"success"]) {
            NSDictionary * dict = responseObject[@"result"];
            NSArray * arr = [ListItemModel mj_objectArrayWithKeyValuesArray:dict[@"banners"]];
            [_bannerArray addObjectsFromArray:arr];
            NSArray * list = [EndsItem mj_objectArrayWithKeyValuesArray:dict[@"latestUpdate"][@"list"]];
            [_contentArray addObjectsFromArray:list];
            _bannerView.imgsList = arr;
            [self.collectionView reloadData];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        Log(@"%@",error);
    }];
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

#pragma mark <SuzeeCollectionViewLayoutDelegate>

- (CGFloat)flowLayout:(SuzeeCollectionViewLayout *)flowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath {
    EndsItem * item = self.contentArray[indexPath.row] ;

    NSURL * url = [NSURL URLWithString:item.cover];
    NSData * data = [NSData dataWithContentsOfURL:url];
    UIImage * img = [UIImage imageWithData:data];
    double height = 0;
    if (img != nil) {
        height = img.size.height * width/img.size.width;
    }
    
    return 100;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return self.contentArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    EndsItem * item = self.contentArray[indexPath.row] ;
    // Configure the cell
    cell.imgURL = item.cover;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    VideoDetailViewController * vc = [[VideoDetailViewController alloc]initWithNibName:NSStringFromClass(VideoDetailViewController.self) bundle:nil];
    
    [self presentViewController:vc animated:true completion:nil];
}
#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
