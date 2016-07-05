//
//  YT_Url.h
//  interview
//
//  Created by 于波 on 16/3/29.
//  Copyright © 2016年 于波. All rights reserved.
//

#ifndef YT_Url_h
#define YT_Url_h

/**
 *  获取验证码（不检测手机号是否注册）
 *  http://www.talk2vc.com/api/v1/login/getcode?mobile=18640418564&source=1
 */
#define Url_SendVerificationCode_NOTVerificationPhoneExist @"http://www.talk2vc.com/api/v1/login/getcode"

/**
 *  获取验证码（登录用户接口）
 *  http://www.talk2vc.com/api/v1/login/getcodeforuser?mobile=18640418564&source=1
 */
#define Url_SendVerificationCode_PhoneExist @"http://www.talk2vc.com/api/v1/login/getcodeforuser"

/**
 *  校验验证码(手机号码为非注册用户)适用于注册前的验证码校验
 *  http://www.talk2vc.com/api/v1/login/validcode?mobile=18640418564&code=111
 */
#define Url_VerificationCode_NOTVerificationPhoneExist @"http://www.talk2vc.com/api/v1/login/validcode"

/**
 *  校验验证码(手机号码为注册用户)适用于已注册用户的验证码校验
 *  http://www.talk2vc.com/api/v1/login/validcodeforuser?mobile=18640418564&code=111
 */
#define Url_VerificationCode_PhoneExist @"http://www.talk2vc.com/api/v1/login/validcodeforuser"

/**
 *  投资人邀请码
 *  http://www.talk2vc.com/api/v1/user/validinvitecode?code=H56XD
 */
#define Url_InviteCode @"http://www.talk2vc.com/api/v1/user/validinvitecode"

/**
 *  注册
 *  http://www.talk2vc.com/api/v1/login/regist?username=18640418564&type=1&password=123456&source=1
 * type = 1 投资人  type = 2 创业者
 */
#define Url_Register @"http://www.talk2vc.com/api/v1/login/regist"

/**
 *  用户真实姓名
 *  http://www.talk2vc.com/api/v1/user/updateParam?type=1&value=ss
 */
#define Url_Set_RealName @"http://www.talk2vc.com/api/v1/user/updateparam"

/**
 *  用户微信号http://www.talk2vc.com/api/v1/user/updateParam?type=2&value=ss
 *  
 */
#define Url_Set_Wechat @"http://www.talk2vc.com/api/v1/user/updateparam"

/**
 *  用户手机号
 *  http://www.talk2vc.com/api/v1/user/updateParam?type=3&value=ss
 */
#define Url_Set_PhoneNum @"http://www.talk2vc.com/api/v1/user/updateparam"

/**
 *  用户地区
 *  http://www.talk2vc.com/api/v1/user/updateParam?type=4&value=ss
 */
#define Url_Set_City @"http://www.talk2vc.com/api/v1/user/updateparam"

/**
 *  用户公司
 *  http://www.talk2vc.com/api/v1/user/updateParam?type=5&value=ss
 */
#define Url_Set_Company @"http://www.talk2vc.com/api/v1/user/updateparam"

/**
 *  用户职位
 *  http://www.talk2vc.com/api/v1/user/updateParam?type=6&value=ss
 */
#define Url_Set_Position @"http://www.talk2vc.com/api/v1/user/updateparam"

/**
 *  用户相关领域
 *  http://www.talk2vc.com/api/v1/user/updateParam?type=7&value=ss
 */
#define Url_Set_Domain @"http://www.talk2vc.com/api/v1/user/updateparam"

/**
 *  投资人自我介绍
 *  http://www.talk2vc.com/api/v1/user/updateParam?type=8&value=ss
 */
#define Url_Set_ToIntroduceMyself @"http://www.talk2vc.com/api/v1/user/updateparam"

/**
 *  忘记密码
 *  http://www.talk2vc.com/api/v1/user/forget/pwdbymobile?password=123123&mobile=18640418564
 */
#define Url_Forget_Pwd @"http://www.talk2vc.com/api/v1/user/forget/pwdbymobile"

/**
 *  发现栏目推荐接口
 *  http://www.talk2vc.com/api/v1/index/findrecommend
 * 更改接口 http://localhost:8084/chxp-apnt/api/v1/index/findhot?page=1
 */
#define Url_Home @"http://www.talk2vc.com/api/v1/index/findhot"

/**
 *  投资人tabbar
 *  http://localhost:8084/chxp-apnt/api/v1/index/investorindex?page=1
 */
#define Url_Investor_Home @"http://www.talk2vc.com/api/v1/index/investorindex"

/**
 *  用户信息完善头像更新（1为头像、2为名片）
 *  http://www.talk2vc.com/api/v1/upload/upimageforuser?type=1
 */
#define Url_Up_Head @"http://www.talk2vc.com/api/v1/upload/upimageforuser?type=1"

/**
 *  用户信息完善头像更新（1为头像、2为名片）
 *  http://www.talk2vc.com/api/v1/upload/upimageforuser?type=2
 */
#define Url_Up_Card @"http://www.talk2vc.com/api/v1/upload/upimageforuser?type=2"

/**
 *  上传项目logo
 *  http://www.talk2vc.com/api/v1/upload/image_file
 */
#define Url_Up_Logo @"http://www.talk2vc.com/api/v1/upload/image_file"

/**
 *  创业者项目接口
 *  http://www.talk2vc.com/api/v1/project/add?projectId&projectName=项目名称&city=1&industry=1,2&stage=1&logo=logo&url=产品链接（暂无）&introduce=项目简介&apntTeamIntro=团队简介&bp=bp地址&bpName=bp名称（需后缀）
 */
#define Url_CreatePerson_Items @"http://www.talk2vc.com/api/v1/project/add"

/**
 *  投资人投资案例
 *  http://www.talk2vc.com/api/v1/user/setinvestcase?content=这是个很傻的事情
 */
#define Url_Set_Sase @"http://www.talk2vc.com/api/v1/user/setinvestcase"

/**
 *  投资人投资案例
 *  http://www.talk2vc.com/api/v1/user/setcourseprice?price=532&hours=2.1
 */
#define Url_Set_Price @"http://www.talk2vc.com/api/v1/user/setcourseprice"

/**
 *  搜索接口
 *  http://www.talk2vc.com/api/v1/search/investor?keywords=李
 */
#define Url_Search @"http://www.talk2vc.com/api/v1/search/investor"

/**
 *  投资人（创业者）详情//http://localhost:8084/chxp-apnt/api/v1/investor/info
 */
#define Url_UserInfo @"http://www.talk2vc.com/api/v1/investor/info"

/**
 *  投资人账户详情
 */
#define Url_Investor_PayInfo @"http://www.talk2vc.com/api/v1/investor/payinfo"

/**
 *  投资人约见详情(约我的团队)
 */
#define Url_Investor_HasMeet @"http://www.talk2vc.com/api/v1/investor/me"

/**
 *  投资人提取现金 //http://www.talk2vc.com/api/v1/investor/withdrawals?money=100
 */
#define Url_Investor_GetMoney @"http://www.talk2vc.com/api/v1/investor/withdrawals"

/**
 *   投资人设置支付账户信息 //http://www.talk2vc.com/api/v1/investor/setpayinfo?cardNo=6222600310014990866&realName=李靖国&aliAccount=aljg1999@126.com&idCard=2323203199009101811
 */
#define Url_Set_AliAccount @"http://www.talk2vc.com/api/v1/investor/setpayinfo"

/**
 *  重置密码接口 http://localhost:8084/chxp-apnt/api/v1/user/reset/pwd?password=123123&newPwd=123456
 */
#define Url_Set_ResetNewPwd @"http://www.talk2vc.com/api/v1/user/reset/pwd"

/**
 *  提现明细 http://localhost:8084/chxp-apnt/wap/records?userId=176724
 */
#define Url_getMoneyExplain @"http://www.talk2vc.com/wap/records?userId=%@"

/**
 *  服务条款
 */
#define Url_Terms_of_Service @"http://www.talk2vc.com/wap/agreement"

/**
 *  上传商业计划书介绍//
 */
#define Url_UpBP @"http://www.talk2vc.com/wap/guide/uploadtip"

/**
 *  提现常见问题
 */
#define Url_CommonQuestion @"http://www.talk2vc.com/wap/questions"

/**
 *  项目信息单独提交接口
 * http://localhost:8084/chxp-apnt/api/v1/project/update?type=6&value=valus&projectId=1110
 * 1项目名称 、2项目阶段 、3行业标签、4所在地区、5简单介绍项目、6.简单介绍团队
 */
#define Url_ItemProduct_Info @"http://www.talk2vc.com/api/v1/project/update"

/**
 *  http://localhost:8084/chxp-apnt/api/v1/project/update?type=8&value=http://7xsd86.com2.z0.glb.qiniucdn.com/2ae381ad573733bf2e489ccb210e4ce3d2529d5d48291f9ad497ac55394f9035&projectId=1110
 * 上传项目logo 成功够 再次发送服务器带上projectId
 */
#define Url_ItemProduct_logo @"http://www.talk2vc.com/api/v1/project/update"

/**
 *  首页轮播图
 * http://localhost:8084/chxp-apnt/api/v1/index/findrecommend

 */
#define Url_Home_Pic @"http://www.talk2vc.com/api/v1/index/findrecommend"

#endif /* YT_Url_h */
