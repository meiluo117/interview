//
//  YT_AboutApp.m
//  interview
//
//  Created by Mickey on 16/6/22.
//  Copyright © 2016年 于波. All rights reserved.
//

#import "YT_AboutApp.h"
#import "HYActivityView.h"
#import <UMSocial.h>
#import "YT_OtherUrl.h"

@interface YT_AboutApp ()
@property (weak, nonatomic) IBOutlet UIView *phoneView;
@property (weak, nonatomic) IBOutlet UIView *sharedAppView;
@property (weak, nonatomic) IBOutlet UILabel *phoneLable;
@property (nonatomic, strong) HYActivityView *activityView;

@end

@implementation YT_AboutApp

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

- (void)createUI
{
    self.NavTitle = @"关于约谈";
    
    UITapGestureRecognizer *phoneTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(callPhone)];
    [self.phoneView addGestureRecognizer:phoneTap];
    
    UITapGestureRecognizer *shareTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sharedApp)];
    [self.sharedAppView addGestureRecognizer:shareTap];
}

- (void)callPhone
{
    YT_WS(weakSelf);
    UIAlertController *alerVc = [UIAlertController alertControllerWithTitle:@"是否拨打客服电话?" message:self.phoneLable.text preferredStyle:UIAlertControllerStyleActionSheet];
    [self presentViewController:alerVc animated:YES completion:nil];
    
    UIAlertAction *phoneCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    
    UIAlertAction *phoneCall = [UIAlertAction actionWithTitle:@"拨打" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        NSString *call = [NSString stringWithFormat:@"tel://%@",weakSelf.phoneLable.text];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:call]];
        
    }];
    
    [alerVc addAction:phoneCancel];
    [alerVc addAction:phoneCall];
}

- (void)sharedApp
{
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    
    if (!self.activityView) {
        self.activityView = [[HYActivityView alloc]initWithTitle:@"分享到" referView:window];
        
        self.activityView.HYbgColor = [UIColor whiteColor];
        //横屏会变成一行6个, 竖屏无法一行同时显示6个, 会自动使用默认一行4个的设置.
        self.activityView.numberOfButtonPerLine = 3;
        
        ButtonView *bv = [[ButtonView alloc]initWithText:@"微信好友" image:[UIImage imageNamed:@"yt_wechat"] handler:^(ButtonView *buttonView){
            //微信好友集成服务
            [UMSocialData defaultData].extConfig.wechatSessionData.url = sharedDownloadAPP;//微信好友分享url
            [UMSocialData defaultData].extConfig.wechatSessionData.title = sharedTitle;//微信好友分享title
            UIImage *image = [UIImage imageNamed:@"appIcon29"];
            
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatSession] content:sharedDetail image:image location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
                if (response.responseCode == UMSResponseCodeSuccess) {
                    
                }
            }];
            
        }];
        [self.activityView addButtonView:bv];
        
        bv = [[ButtonView alloc]initWithText:@"QQ好友" image:[UIImage imageNamed:@"yt_qq"] handler:^(ButtonView *buttonView){
            [UMSocialData defaultData].extConfig.qqData.url = sharedDownloadAPP;//qq好友分享url
            [UMSocialData defaultData].extConfig.qqData.title = sharedTitle;//qq好友分享title
            UIImage *image = [UIImage imageNamed:@"appIcon29"];
            
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQQ] content:sharedDetail image:image location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
                if (response.responseCode == UMSResponseCodeSuccess) {
                    
                }
            }];
        }];
        [self.activityView addButtonView:bv];
        
        bv = [[ButtonView alloc]initWithText:@"朋友圈" image:[UIImage imageNamed:@"yt_wechatTime"] handler:^(ButtonView *buttonView){
            
            [UMSocialData defaultData].extConfig.wechatTimelineData.url = sharedDownloadAPP;//
            [UMSocialData defaultData].extConfig.wechatTimelineData.title = sharedDetail;//
            UIImage *image = [UIImage imageNamed:@"appIcon29"];
            
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatTimeline] content:sharedTitle image:image location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
                if (response.responseCode == UMSResponseCodeSuccess) {
                    
                }
            }];
        }];
        [self.activityView addButtonView:bv];
    }
    
    [self.activityView show];
}

@end
