//
//  ViewController.m
//  GDMapListOnline
//
//  Created by 郭达 on 15/9/14.
//  Copyright (c) 2015年 guoda. All rights reserved.
//

#import "ViewController.h"
#import "MapListViewController.h"
@interface ViewController ()
{
    NSMutableArray *_mapDataArray1;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _mapDataArray1 = [NSMutableArray array];
    [self startDownloadMapData];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(100, 100, 100, 30);
    [button setTitle:@"Map" forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(btn) forControlEvents:UIControlEventTouchUpInside];
}
- (void)btn {
    MapListViewController *map = [[MapListViewController alloc] init];
    map.mapDataArray  =  _mapDataArray1;
    [self presentViewController:map animated:YES completion:nil];
}


#pragma mark - 下载地图数据
- (void)startDownloadMapData {
//    NSString *Pver = [[OperationCenter shareInstance] bundleversion];
    //    NSString *urlString = @"http://123.56.131.79/XUIWeb/getmaplist";
    NSString *urlString = GET_maplist;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:@{@"Pver":@"1"} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *array1 = dic[@"provinces"];
        for (NSDictionary *dic2 in array1) {
            mapProvincesModel *model = [[mapProvincesModel alloc] init];
            [model setValuesForKeysWithDictionary:dic2];
            model.state = @"NO";
            [_mapDataArray1 addObject:model];
        }
        //----- 创建地图列表 ------
//        [self createMapList];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请检查网络" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
