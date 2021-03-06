//
//  YT_SuccessfulCaseController.m
//  interview
//
//  Created by 于波 on 16/3/25.
//  Copyright © 2016年 于波. All rights reserved.
//
#define LimitMaxWord 100
#import "YT_SuccessfulCaseController.h"
#import "YT_InvestorPersonInfoModel.h"

@interface YT_SuccessfulCaseController ()<UITextViewDelegate>
@property (nonatomic,weak)UITextView *explainTextView;
@property (nonatomic,weak)UILabel *wordLable;
@end

@implementation YT_SuccessfulCaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_interactivePopDisabled = YES;
    self.NavTitle = @"投资案例";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(save:)];
    
    [self createUI];
}

- (void)createUI
{
    UITextView *textV = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 300)];
    textV.font = [UIFont systemFontOfSize:14];
    textV.textColor = [UIColor blackColor];
    textV.backgroundColor = [UIColor whiteColor];
    textV.delegate = self;
    textV.scrollEnabled = NO;
    textV.alwaysBounceVertical = NO;
    self.explainTextView = textV;
    [self.view addSubview:self.explainTextView];
    self.explainTextView.text = [YT_InvestorPersonInfoModel sharedPersonInfoModel].investorCase;
    
    UILabel *wordLable = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth - 50, CGRectGetMaxY(self.explainTextView.frame) - 20, 100, 20)];
    wordLable.font = [UIFont systemFontOfSize:12];
    wordLable.textColor = [UIColor blackColor];
    
    if (self.explainTextView.text.length == 0) {
        wordLable.text = [NSString stringWithFormat:@"0/%d",LimitMaxWord];
    }else{
        wordLable.text = [NSString stringWithFormat:@"%lu/%d",(unsigned long)self.explainTextView.text.length,LimitMaxWord];
    }
    
    self.wordLable = wordLable;
    [self.view addSubview:self.wordLable];
}

- (void)cancel
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)save:(UIButton *)btn
{
    [self sendRequest];
//    [YT_InvestorPersonInfoModel sharedPersonInfoModel].investorCase = self.explainTextView.text;
//    [self.navigationController popViewControllerAnimated:YES];
}

- (void)sendRequest
{
    YT_WS(weakSelf);
    NSDictionary *params = @{@"content":self.explainTextView.text};
    [YBHttpNetWorkTool post:Url_Set_Sase params:params success:^(id json) {
        NSInteger status = [json[@"code"] integerValue];
        if (status == 1) {
            YT_LOG(@"上传成功案例success");
            [YT_InvestorPersonInfoModel sharedPersonInfoModel].investorCase = weakSelf.explainTextView.text;
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
        
    } failure:^(NSError *error) {
        YT_LOG(@"上传成功案例error:%@",error);
        [weakSelf.navigationController popViewControllerAnimated:YES];
        
    } header:[YT_InvestorPersonInfoModel sharedPersonInfoModel].ticket ShowWithStatusText:nil];
}

#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    //判断加上输入的字符，是否超过界限
    NSString *str = [NSString stringWithFormat:@"%@%@", textView.text, text];
    if (str.length > LimitMaxWord)
    {
        textView.text = [textView.text substringToIndex:LimitMaxWord];
        return NO;
    }
    return YES;
    
//    NSString *string = [textView.text stringByReplacingCharactersInRange:range withString:text];
//    
//    if ([string length] > LimitMaxWord)
//        
//    {
//        
//        string = [string substringToIndex:LimitMaxWord];
//        
//    }
//    
//    textView.text = string;
//    
//    return NO;
}

- (void)textViewDidChange:(UITextView *)textView
{
    //该判断用于联想输入
    if (textView.text.length > LimitMaxWord)
    {
        textView.text = [textView.text substringToIndex:LimitMaxWord];
    }
    
    self.wordLable.text = [NSString stringWithFormat:@"%lu/%d", (unsigned long)[textView.text length], LimitMaxWord];
}



@end
