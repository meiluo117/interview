//
//  YT_CreateForMeController.m
//  interview
//
//  Created by 于波 on 16/3/21.
//  Copyright © 2016年 于波. All rights reserved.

#define HeadViewHeight 140.0f
#define FootViewHeight 40.0f
#define HeadImageW 80.0f //头像宽和高
#define HeadImageY 20.0f //头像的y坐标
#define HeadImageX (ScreenWidth - HeadImageW) / 2 //头像的x坐标

#import "YT_CreateForMeController.h"
#import "YT_PhoneRegisterController.h"
#import "YT_SetCreateInfoCell.h"
#import "YT_LoginController.h"
#import "UIButton+YBExtension.h"
#import "YT_CreateDateTableController.h"
#import "YT_SetPwdBeforeController.h"
#import "YT_SetCreateInfoController.h"
#import "YT_SetCreateDetailController.h"
#import "YT_CreatePersonInfoModel.h"
#import "YT_SetCreateInfoForMeController.h"
#import <MJExtension.h>
#import "YT_NavigationController.h"
#import "YT_CommonConstList.h"
#import "HYActivityView.h"
#import <UMSocial.h>
#import "YT_OtherUrl.h"
#import "YT_AboutApp.h"
#import "UITabBar+YBbadge.h"

@interface YT_CreateForMeController ()

@property (nonatomic,strong)NSArray *titleArray;
@property (nonatomic,weak)UILabel *nameLable;
@property (nonatomic,weak)UIImageView *headImageView;
@property (nonatomic, strong) HYActivityView *activityView;
@end

@implementation YT_CreateForMeController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    
    YT_WS(weakSelf);
    [YBHttpNetWorkTool post:Url_UserInfo params:nil success:^(id json) {
        YT_LOG(@"----%@",json);
        NSInteger statusCode = [json[@"code"] integerValue];
        if (statusCode == 1) {
            NSDictionary *dataDict = json[@"data"];
            [YT_CreatePersonInfoModel mj_objectWithKeyValues:dataDict];
//            [weakSelf cutStr];
//            [weakSelf.tableView reloadData];
            [weakSelf createHeadView];
        }else{

        }
    } failure:^(NSError *error) {

    } header:[YT_CreatePersonInfoModel sharedPersonInfoModel].ticket ShowWithStatusText:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.tabBarController.tabBar showBadgeOnItemIndex:2];
    
    self.view.backgroundColor = YT_Color(244, 244, 244, 1);
    
    self.titleArray = @[@[@"我约的投资人",@"个人信息",@"项目信息",@"重置密码"],
                     @[@"关于约谈"]];
    UITableView *tableV = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    tableV.bounces = NO;
    self.tableView = tableV;
    
    [self createHeadView];
    [self createFootView];
}

- (void)createHeadView
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, HeadViewHeight)];
    headView.backgroundColor = YT_Color(226, 252, 240, 1);
    self.tableView.tableHeaderView = headView;
    
    UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(HeadImageX, HeadImageY, HeadImageW, HeadImageW)];
    if ([YT_CreatePersonInfoModel sharedPersonInfoModel].headImg.length != 0) {
        [headImageView sd_setImageWithURL:[NSURL URLWithString:[YT_CreatePersonInfoModel sharedPersonInfoModel].headImg]];
    }else{
        headImageView.image = [UIImage imageNamed:@"touxiang"];
    }
    headImageView.layer.cornerRadius = HeadImageW / 2;
    headImageView.layer.masksToBounds = YES;
    self.headImageView = headImageView;
    [headView addSubview:self.headImageView];
    
    UILabel *nameLable = [[UILabel alloc] initWithFrame:CGRectMake((ScreenWidth - 200) / 2, HeadImageY + HeadImageW + 5, 200, 30)];
    nameLable.text = [YT_CreatePersonInfoModel sharedPersonInfoModel].realName;
    nameLable.textAlignment = NSTextAlignmentCenter;
    nameLable.font = [UIFont systemFontOfSize:14];
    nameLable.textColor = titleColor;
    self.nameLable = nameLable;
    [headView addSubview:self.nameLable];
}

- (void)createFootView
{
    UIButton *footBtn = [UIButton otherBtnWithTarget:self Action:@selector(exitClick:) btnTitle:@"退出登录" andBtnFrame:CGRectMake(0, 0, ScreenWidth, 60)];
    footBtn.backgroundColor = [UIColor whiteColor];
    footBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    self.tableView.tableFooterView = footBtn;
}

- (void)exitClick:(UIButton *)btn
{
    [self exitAlert];
}

- (void)exitAlert
{
    UIAlertController *alerVc = [UIAlertController alertControllerWithTitle:@"" message:@"您确定退出登录?" preferredStyle:UIAlertControllerStyleActionSheet];
    [self presentViewController:alerVc animated:YES completion:nil];
    
    UIAlertAction *exit = [UIAlertAction actionWithTitle:@"退出登录" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        //清空用户model
        YT_CreatePersonInfoModel *model = [YT_CreatePersonInfoModel sharedPersonInfoModel];
        [model clear];
        //清空账号
        NSUserDefaults *userDefaults  = [NSUserDefaults standardUserDefaults];
        [userDefaults removeObjectForKey:USER_PHONE];
        [userDefaults removeObjectForKey:USER_PASSWORD];
        [userDefaults removeObjectForKey:USER_TOKEN];
        [userDefaults synchronize];
        
        YT_NavigationController *nav = [[YT_NavigationController alloc] initWithRootViewController:[[YT_LoginController alloc] init]];
        [UIApplication sharedApplication].keyWindow.rootViewController = nav;
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    [alerVc addAction:exit];
    [alerVc addAction:cancel];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.titleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.titleArray[section] count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * string = @"setCreateInfo";
    
    YT_SetCreateInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:string];
    
    if (nil == cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YT_SetCreateInfoCell" owner:self options:nil] lastObject];
    }
    cell.titleLable.text = self.titleArray[indexPath.section][indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {//我越的投资人
            YT_CreateDateTableController *createDateVc = [[YT_CreateDateTableController alloc] init];
            [self.navigationController pushViewController:createDateVc animated:YES];
        }else if (indexPath.row == 1){//个人信息
            YT_SetCreateInfoController *setCreateVc = [[YT_SetCreateInfoController alloc] init];
            setCreateVc.navTitleString = @"个人信息";
            setCreateVc.isExistBtn = NO;
            [self.navigationController pushViewController:setCreateVc animated:YES];
        }else if (indexPath.row == 2){//项目信息
            YT_SetCreateInfoForMeController *setCreateInfoForMEVc = [[YT_SetCreateInfoForMeController alloc] init];
            [self.navigationController pushViewController:setCreateInfoForMEVc animated:YES];
        }else if (indexPath.row == 3){//重置密码
            YT_SetPwdBeforeController *setPwdBeforeVc = [[YT_SetPwdBeforeController alloc] init];
            [self.navigationController pushViewController:setPwdBeforeVc animated:YES];
        }
    }else if (indexPath.section == 1){//分享
        YT_AboutApp *aboutAppVc = [[YT_AboutApp alloc] init];
        [self.navigationController pushViewController:aboutAppVc animated:YES];
    }
    
}



@end
