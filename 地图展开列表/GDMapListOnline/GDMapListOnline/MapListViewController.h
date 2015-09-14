//
//  MapListViewController.h
//  GDMapListOnline
//
//  Created by 郭达 on 15/9/14.
//  Copyright (c) 2015年 guoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapModel.h"
#import "UIKit+AFNetworking.h"
#import "AFNetworking.h"
#define GET_maplist @"http://123.57.25.103/XUIWeb/getmaplist"
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width

#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
@interface MapListViewController : UIViewController
//NSMutableArray *_mapDataArray;
@property (nonatomic, copy) NSArray *mapDataArray;
@end
