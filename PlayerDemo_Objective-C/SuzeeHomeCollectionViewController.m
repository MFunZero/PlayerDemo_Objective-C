//
//  SuzeeHomeCollectionViewController.m
//  PlayerDemo_Objective-C
//
//  Created by fanzz on 16/7/5.
//  Copyright © 2016年 fanzz. All rights reserved.
//

#import "SuzeeHomeCollectionViewController.h"
#import "SuzeeCollectionViewLayout.h"
#import "AFNetWorking.h"
#import "MJExtension.h"
#import "URLItem.h"
#import "SingleItemModel.h"
#import "ImageCollectionViewCell.h"



@interface SuzeeHomeCollectionViewController ()<SuzeeCollectionViewLayoutDelegate>

@property (strong,nonatomic) NSMutableArray * items;

@property (strong,nonatomic) AFHTTPSessionManager * mgr;

@end

@implementation SuzeeHomeCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (AFHTTPSessionManager *)mgr {
    if (!_mgr) {
        self.mgr = [[AFHTTPSessionManager alloc] init];
    }
    return  _mgr;
}
- (NSMutableArray<SingleItemModel *> *)items {
    if (!_items) {
        
        self.items = [[NSMutableArray alloc] init];
    }
    return _items;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    SuzeeCollectionViewLayout *layoutNew = [[SuzeeCollectionViewLayout alloc] init] ;
    layoutNew.delegate = self;
    self.collectionView.collectionViewLayout = layoutNew;
    
//    self.clearsSelectionOnViewWillAppear = NO;
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    
    // Register cell classes
//    [self.collectionView registerClass:[ImageCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(ImageCollectionViewCell.self) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self requestData];
    
    // Do any additional setup after loading the view.
}

- (void)requestData {
    
    
    [self.mgr GET:BaseUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"progress%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [responseObject writeToFile:@"//Users/fanzz/Documents/GCDWorkspace/PlayerDemo_Objective-C/data.plist"  atomically:YES];
//        NSLog(@"responseOBJ:%@",responseObject);
        if ([responseObject[@"status"] intValue] == 1){
            NSLog(@"GET successful");
            URLItem * item = [URLItem mj_objectWithKeyValues:responseObject[@"data"]];
            NSLog(@"URLItem:%@",item.object_list);
            [_items addObjectsFromArray:item.object_list];

            [self.collectionView reloadData];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error);
    }];
}

- (CGFloat)flowLayout:(SuzeeCollectionViewLayout *)flowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    SingleItemModel * item = [SingleItemModel mj_objectWithKeyValues:_items[row]];
    float wid = 1 ;
    float height = 0;
    if (item.photo != nil) {
        wid = [[item.photo objectForKey:@"width"] floatValue];
        height = [[item.photo objectForKey:@"height"] floatValue];
        
    }
    
    height = height * width/wid;
    
    return height;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    SingleItemModel * item = [SingleItemModel mj_objectWithKeyValues:_items[indexPath.row]];

        cell.backgroundColor = [UIColor cyanColor];

    cell.imgURL = [item.photo objectForKey:@"path"];
//    cell.layer.borderColor = [[UIColor blueColor]CGColor];
    
    return cell;
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
