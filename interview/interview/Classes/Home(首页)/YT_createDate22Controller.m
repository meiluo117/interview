//
//  YT_createDate22Controller.m
//  interview
//
//  Created by Mickey on 16/6/12.
//  Copyright © 2016年 于波. All rights reserved.
//

#import "YT_createDate22Controller.h"
#import "YT_DateOrderCell.h"
#import "YT_CreatePersonInfoModel.h"
#import "YT_DateOrderInfoRequestModel.h"
#import "YT_DateOrderInfoDataModel.h"
#import "YT_DateOrderInfoIndustryListModel.h"
#import <MJExtension.h>
#import "YT_DetailsHomeWebController.h"
#import "NSString+YBExtension.h"
#import "YT_ItemModel.h"

@interface YT_createDate22Controller ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableV;
@property (weak, nonatomic) IBOutlet UILabel *orderLable;
@property (weak, nonatomic) IBOutlet UILabel *orderTimeLable;
@property (strong,nonatomic) NSMutableArray *dataArray;
@end

@implementation YT_createDate22Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createData];
}

- (void)createData
{
    YT_WS(weakSelf);
    NSDictionary *params = @{@"orderId":self.orderID};
    [YBHttpNetWorkTool post:Url_Date_CreateOrder params:params success:^(id json) {
        YT_LOG(@"order:%@",json);
        NSInteger status = [json[@"code"] integerValue];
        if (status == 1) {
            
            [YT_DateOrderInfoRequestModel mj_objectWithKeyValues:json];
            [weakSelf.dataArray addObject:[YT_DateOrderInfoRequestModel sharedModel].data];
            
            [weakSelf createUI];
        }else{
            
            [SVProgressHUD showErrorWithStatus:json[@"msg"]];
        }
        
    } failure:^(NSError *error) {
        
    } header:[YT_CreatePersonInfoModel sharedPersonInfoModel].ticket ShowWithStatusText:@""];
}

- (void)createUI
{
    self.NavTitle = @"已拒绝";
    
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    self.tableV.showsVerticalScrollIndicator = NO;
    self.tableV.showsHorizontalScrollIndicator = NO;
    self.tableV.bounces = NO;
    self.tableV.backgroundColor = [UIColor yellowColor];
    self.tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    NSString *order = [NSString orderNumberStringWithFormat:[YT_DateOrderInfoRequestModel sharedModel].data.orderNo];
    self.orderLable.attributedText = [NSString orderNumberLableTextAttributedWithString:order];
    self.orderTimeLable.text = [YT_DateOrderInfoRequestModel sharedModel].data.orderTime;
    
    [self.tableV reloadData];//??????
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"home";
    
    YT_DateOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (nil == cell) {
        cell = [[YT_DateOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    if (self.dataArray.count > indexPath.row){
        cell.model = self.dataArray[0];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YT_DetailsHomeWebController *investorDetailWebVc = [[YT_DetailsHomeWebController alloc] init];
    investorDetailWebVc.isExistDateBtn = YES;
    YT_ItemModel *model = self.dataArray[indexPath.row];
    investorDetailWebVc.model = model;
    [self.navigationController pushViewController:investorDetailWebVc animated:YES];
}

#pragma mark - 懒加载
- (NSMutableArray *)dataArray
{
    if (nil == _dataArray) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
