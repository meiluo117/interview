//
//  YT_SetNameController.h
//  interview
//
//  Created by 于波 on 16/3/23.
//  Copyright © 2016年 于波. All rights reserved.
//

#import "YT_SetSomethingController.h"

@interface YT_SetNameController : YT_SetSomethingController
@property (copy,nonatomic) void(^messageCallBack)(NSString *msg);
@end
