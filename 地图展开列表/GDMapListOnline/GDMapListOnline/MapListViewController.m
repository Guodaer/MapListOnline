//
//  MapListViewController.m
//  GDMapListOnline
//
//  Created by 郭达 on 15/9/14.
//  Copyright (c) 2015年 guoda. All rights reserved.
//

#import "MapListViewController.h"

@interface MapListViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_dataArray;
}
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MapListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataArray = [NSMutableArray array];
    for (int i=0; i<_mapDataArray.count; i++) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        mapProvincesModel *model = _mapDataArray[i];
        [dic setValue:model.pname forKey:@"pname"];
        [dic setValue:model.citys forKey:@"citys"];
        [dic setValue:model.pid forKey:@"pid"];
        [dic setValue:model.spname forKey:@"spname"];
        [dic setValue:model.state  forKey:@"state"];
        [_dataArray addObject:dic];
    }
//    NSLog(@"%@",_dataArray);
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _mapDataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    mapProvincesModel *model = _mapDataArray[section];
    NSDictionary *dic = _dataArray[section];
    if ([[dic objectForKey:@"state"] isEqualToString:@"NO"]) {
        return 0;
    }
    else{
        NSArray *array = (NSArray*)model.citys;
        NSLog(@"array  %@",array);
        return array.count;
    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *cellID = @"cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//    if (cell == nil) {
      UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
//    }
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, SCREENWIDTH - 100, 44)];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.textColor = [UIColor grayColor];
    nameLabel.font = [UIFont systemFontOfSize:17];
    NSDictionary *dic = _dataArray[indexPath.section];
    if ([[dic objectForKey:@"state"] isEqualToString:@"YES"]) {
        //背景
        if (indexPath.row%2 == 0) {
            cell.backgroundColor = [self GDStringToColor:@"f1f1f1" alpha:1];
        }
        else{
            cell.backgroundColor = [self GDStringToColor:@"f6f6f6" alpha:1];
        }
        
        nameLabel.text = [[[_dataArray[indexPath.section]objectForKey:@"citys"] objectAtIndex:indexPath.row] objectForKey:@"scname"];
        [cell addSubview:nameLabel];
        NSLog(@"nameLabel %@",nameLabel);
        
        
    }
    
    return cell;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    mapProvincesModel *model = _mapDataArray[section];
    [button setBackgroundColor:[UIColor whiteColor]];
    button.tag = section;
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 150, 44)];
    label.text = model.spname;
    label.textColor = [self GDStringToColor:@"808080" alpha:1];
    label.textAlignment = NSTextAlignmentLeft;
    [button addSubview:label];
    //下划线
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 43, SCREENWIDTH, 0.5)];
    imageView.backgroundColor = [self GDStringToColor:@"c1c1c1" alpha:1];
    [button addSubview:imageView];
    if (model.citys != nil) {
        NSArray *array = (NSArray*)model.citys;
        if (array.count > 1) {//含市的超过一个就不是直辖市
            
        }
        else {//直辖市-----=====------
            if (array.count == 1) {
                
                
            }
        }
        
    }
    return button;
    
}
#pragma mark - 省
- (void)btnClick:(UIButton *)sender {
    NSLog(@"11111");
    NSDictionary *dic = _dataArray[sender.tag];
    mapProvincesModel *model = _mapDataArray[sender.tag];
    NSArray *array = (NSArray *)model.citys;
    if (array.count > 1) {
//        NSLog(@"%ld",(long)sender.tag);
//        UIView *view = [self.view viewWithTag:sender.tag];//新加的
//        UIButton *button = (UIButton*)view;
        
        if ([[dic objectForKey:@"state"] isEqualToString:@"NO"]) {
            [dic setValue:@"YES" forKey:@"state"];
//            [_cityArray addObjectsFromArray:array];
            [_dataArray removeObjectAtIndex:sender.tag];
            [_dataArray insertObject:dic atIndex:sender.tag];
        }
        else if([[dic objectForKey:@"state"] isEqualToString:@"YES"]){
            [dic setValue:@"NO" forKey:@"state"];
            [_dataArray removeObjectAtIndex:sender.tag];
            [_dataArray insertObject:dic atIndex:sender.tag];
            
        }
        
        [_tableView reloadData];
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIColor *) GDStringToColor: (NSString *) stringToConvert alpha:(float)alpha
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alpha];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
