//
//  MapModel.h
//  GDMapListOnline
//
//  Created by 郭达 on 15/9/14.
//  Copyright (c) 2015年 guoda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MapModel : NSObject

@end
//城市列表市
@interface mapCitysModel : NSObject
@property (copy,nonatomic) NSString *cid;
@property (copy,nonatomic) NSString *cname;
@property (copy,nonatomic) NSString *scname;

@end
//地图省
@interface mapProvincesModel : NSObject
@property (copy,nonatomic) NSString *pname;
@property (copy,nonatomic) NSString *citys;
@property (copy,nonatomic) NSString *pid;
@property (copy,nonatomic) NSString *spname;
@property (copy, nonatomic) NSString *state;//自己定义状态
@end
