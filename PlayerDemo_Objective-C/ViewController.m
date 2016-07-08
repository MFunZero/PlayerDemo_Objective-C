//
//  ViewController.m
//  PlayerDemo_Objective-C
//
//  Created by fanzz on 16/7/5.
//  Copyright © 2016年 fanzz. All rights reserved.
//

#import "ViewController.h"
#import "SuzeeHomeCollectionViewController.h"
#import "SuzeeCollectionViewLayout.h"
#import "VideoCollectionViewController.h"


@interface ViewController ()<SuzeeCollectionViewLayoutDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}
- (void)viewDidAppear:(BOOL)animated {
    SuzeeCollectionViewLayout *layoutNew = [[SuzeeCollectionViewLayout alloc] init] ;
    
//    SuzeeHomeCollectionViewController * vc = [[SuzeeHomeCollectionViewController alloc] initWithCollectionViewLayout:layoutNew];
    VideoCollectionViewController * vc = [[VideoCollectionViewController alloc] initWithCollectionViewLayout:layoutNew];

    
    [self presentViewController:vc animated:YES completion:^{
        NSLog(@"present");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
