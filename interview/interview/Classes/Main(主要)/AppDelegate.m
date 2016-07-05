//
//  AppDelegate.m
//  interview
//
//  Created by 于波 on 16/3/12.
//  Copyright © 2016年 于波. All rights reserved.
//1、搜索 2、自动取消订单 3、轮播图点击 4、左右滑动，底部无数据改成，加载完成 5、左右滑动，查看投资人，跳转网页 6、投资人tabbar，点击跳转网页  7、评价成功，分享
//已解决 6\3\4\5\ 7（点击空白，分享hide，此时需要跳转页面）\1 \2

#import "AppDelegate.h"
#import "YT_TabBarController.h"
#import "YT_LoginController.h"
#import "YT_NavigationController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "YT_CreatePersonInfoModel.h"
#import "YT_OtherUrl.h"
#import "YT_InvestorPersonInfoModel.h"
#import "YT_InvestorItemsInfoModel.h"
#import "YT_CreatePersonInfoModel.h"
#import "YT_CreateItemsInfoModel.h"
#import <MJExtension.h>
#import "YT_CommonConstList.h"
#import "YT_DateOrderInfoRequestModel.h"
#import "YT_DateOrderInfoDataModel.h"
#import <UMSocial.h>
//#import <UMSocialSinaHandler.h>
#import <UMSocialWechatHandler.h>
#import <UMSocialQQHandler.h>
#import "UMessage.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//***************************获取iphone设备信息****************************************
    UIDevice* curDev = [UIDevice currentDevice];
    NSUUID *uuid = [NSUUID UUID];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:app_Version forKey:@"appVer"];//app版本
    [defaults setObject:curDev.model forKey:@"client"];//iphone/ipad设备
    [defaults setObject:curDev.systemVersion forKey:@"os"];//iphone/ipad系统版本
    [defaults setObject:uuid.UUIDString forKey:@"did"];//iphoneUUID
//****************************获取iphone设备信息****************************************
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
//    YT_LoginController *loginVc = [[YT_LoginController alloc] init];
//    YT_NavigationController *nav = [[YT_NavigationController alloc] initWithRootViewController:loginVc];
//    self.window.rootViewController = nav;
    
    UIViewController *loginVc = [[UIViewController alloc] init];//防止iOS9崩溃
    self.window.rootViewController = loginVc;//防止iOS9崩溃
    
    [self.window makeKeyAndVisible];
    
    NSString *user_token = [defaults objectForKey:USER_TOKEN];
    YT_LOG(@"token----%@",user_token);
    if (user_token.length == 0) {
        //没登录过，跳转登陆页面
        YT_LoginController *loginVc = [[YT_LoginController alloc] init];
        YT_NavigationController *nav = [[YT_NavigationController alloc] initWithRootViewController:loginVc];
        self.window.rootViewController = nav;
    }else{
        //登陆过，自动登陆，获取个人信息
//        [SVProgressHUD showWithStatus:@"登录登录..."];
//        [NSThread sleepForTimeInterval:3];
        [self sendUserInfoRequestWithToken:user_token];
    }
    
    //****************************注册第三方服务****************************************
    [self UMengShared];//注册友盟分享
//    [self UMengPush:launchOptions];//注册友盟推送
    //****************************注册第三方服务****************************************
    
    //应用未启动（不在后台和前台的情况下）点击推送消息进入应用or点击app icon进入应用都会调用这个方法
//    if (launchOptions) {
//        NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
//        if (userInfo) {
//            //接收到远程推送进行相应的逻辑处理
//            YT_LOG(@"remoteNotification---%@",userInfo);
//        }
//    }
//    
//    [UMessage addAlias:@"112233" type:@"product" response:^(id responseObject, NSError *error) {
//        YT_LOG(@"addAlias_responseObject---%@",responseObject);
//    }];
    
    return YES;
}

- (void)UMengPush:(NSDictionary *)launchOptions
{
    //设置 AppKey 及 LaunchOptions
    [UMessage startWithAppkey:umengAppKey launchOptions:launchOptions];
    
    //1.3.0版本开始简化初始化过程。如不需要交互式的通知，下面用下面一句话注册通知即可。
    [UMessage registerForRemoteNotifications];
}

//友盟分享
- (void)UMengShared
{
    //友盟分享
    [UMSocialData setAppKey:umengAppKey];
    //微博
//    [UMSocialSinaHandler openSSOWithRedirectURL:WeiboSSO];
    //QQ
    [UMSocialQQHandler setQQWithAppId:QQWithAppId appKey:QQWithAppKey url:QQWithUrl];
    //微信
    [UMSocialWechatHandler setWXAppId:WXAppId appSecret:WXAppSecret url:WXWithUrl];
}

//请求个人信息
- (void)sendUserInfoRequestWithToken:(NSString *)userToken
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    YT_WS(weakSelf);
    [YBHttpNetWorkTool post:Url_UserInfo params:nil success:^(id json) {
//        YT_LOG(@"----个人信息%@",json);
        NSInteger statusCode = [json[@"code"] integerValue];
        
        if (statusCode == 1) {
            NSDictionary *dataDict = json[@"data"];
            NSInteger type = [dataDict[@"type"] integerValue];
            
            NSMutableArray *itemTagTitleArray = [NSMutableArray array];
            NSString *indexString = [NSMutableString string];
            
            if (type == 1) {
                [userDefaults setObject:@"touzi" forKey:USER_ID];
                [YT_InvestorPersonInfoModel sharedPersonInfoModel].ticket = userToken;
                
                [YT_InvestorPersonInfoModel mj_objectWithKeyValues:dataDict];
                
                for (YT_InvestorItemsInfoModel *model in [YT_InvestorPersonInfoModel sharedPersonInfoModel].industryList) {
                    [itemTagTitleArray addObject:model.value];
                }
                [YT_InvestorPersonInfoModel sharedPersonInfoModel].itemArray = [itemTagTitleArray copy];
                
                for (NSString *str in itemTagTitleArray) {
                    indexString = [indexString stringByAppendingFormat:@"%@,",str];
                    [YT_InvestorPersonInfoModel sharedPersonInfoModel].itemTagTitle = [indexString substringToIndex:indexString.length - 1];
                }
                
            }else{
                [userDefaults setObject:@"chuangye" forKey:USER_ID];
                [YT_CreatePersonInfoModel sharedPersonInfoModel].ticket = userToken;
                [YT_CreatePersonInfoModel sharedPersonInfoModel].projectId = dataDict[@"projectId"];
                
                [YT_CreatePersonInfoModel mj_objectWithKeyValues:dataDict];
                
                for (YT_CreateItemsInfoModel *model in [YT_CreatePersonInfoModel sharedPersonInfoModel].industryList) {
                    [itemTagTitleArray addObject:model.value];
                }
                [YT_CreatePersonInfoModel sharedPersonInfoModel].itemArray = [itemTagTitleArray copy];
                
                for (NSString *str in itemTagTitleArray) {
                    indexString = [indexString stringByAppendingFormat:@"%@,",str];
                    [YT_CreatePersonInfoModel sharedPersonInfoModel].itemTagTitle = [indexString substringToIndex:indexString.length - 1];
                }
                
                
                NSString *itemIndex = [NSMutableString string];
                for (YT_CreateItemsInfoModel *model in [YT_CreatePersonInfoModel sharedPersonInfoModel].industryList) {
                    itemIndex = [itemIndex stringByAppendingFormat:@"%@,",model.index];
                    [YT_CreatePersonInfoModel sharedPersonInfoModel].itemTag = [itemIndex substringToIndex:itemIndex.length - 1];
                }
            }
            
            UITabBarController *tabBar = [[YT_TabBarController alloc] init];
            [UIApplication sharedApplication].keyWindow.rootViewController = tabBar;
        }else{
//            [weakSelf showWarning:json[@"msg"]];
        }
    } failure:^(NSError *error) {
        
    } header:userToken ShowWithStatusText:@"正在登陆..."];
    
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            YT_LOG(@"支付宝返回result = %@",resultDic);
            
            //支付宝返回9000，向服务器发送确认请求
            NSInteger status = [resultDic[@"resultStatus"] integerValue];
            if (status == 9000) {
                [[NSNotificationCenter defaultCenter] postNotificationName:NSNotification_PaySure object:nil];
//                [weakSelf sendPaySureRequest];
            }
        }];
    }
    return YES;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            YT_LOG(@"9.0以后使用新API接口,支付宝返回result = %@",resultDic);
            
            //支付宝返回9000，向服务器发送确认请求
            NSInteger status = [resultDic[@"resultStatus"] integerValue];
            if (status == 9000) {
                [[NSNotificationCenter defaultCenter] postNotificationName:NSNotification_PaySure object:nil];
//                [weakSelf sendPaySureRequest];
            }
            
        }];
    }
    return YES;
}
//发送支付信息
- (void)sendPaySureRequest
{
    NSString *orderId = [YT_DateOrderInfoRequestModel sharedModel].data.orderId;
    NSDictionary *params = @{@"orderId":orderId};
    
    [YBHttpNetWorkTool post:Url_AliPay_AgainSure params:params success:^(id json) {
        YT_LOG(@"支付成功向后台确认%@",json);
        NSInteger status = [json[@"code"] integerValue];
        if (status == 1) {
            //向服务器确认，支付成功
            [SVProgressHUD showSuccessWithStatus:json[@"msg"]];
            YT_LOG(@"支付完成 发出了通知");
            [[NSNotificationCenter defaultCenter] postNotificationName:NSNotification_PaySure object:nil];
            
        }else{
            //向服务器确认，支付失败
            [SVProgressHUD showErrorWithStatus:json[@"msg"]];
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"请求超时"];
    } header:[YT_CreatePersonInfoModel sharedPersonInfoModel].ticket ShowWithStatusText:@"正在提交..."];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    //取消下载
    [manager cancelAll];
    
    //清除内存中的所有图片
    [manager.imageCache clearMemory];
}
//友盟推送
//- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
//{
//    // 1.2.7版本开始不需要用户再手动注册devicetoken，SDK会自动注册
//    //[UMessage registerDeviceToken:deviceToken];
//    YT_LOG(@"%@",[[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""]                  stringByReplacingOccurrencesOfString: @">" withString: @""]                 stringByReplacingOccurrencesOfString: @" " withString: @""]);
//}
//
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
//{
//    YT_LOG(@"IOS如何跳转到指定页面_didReceiveRemoteNotification_userInfo-----:%@",userInfo);
//    [UMessage setAutoAlert:NO];//关闭友盟弹出框
//    [UMessage didReceiveRemoteNotification:userInfo];
//    
//    if (userInfo) {
//        if ([userInfo[@"type"] isEqualToString:@"1"]) {
//            
//            [[NSNotificationCenter defaultCenter] postNotificationName:ReceiveRemoteNotification object:nil];
//        }
//    }
//     [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
//    
//}

@end
