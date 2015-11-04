//
//  ViewController.m
//  AFN封装
//
//  Created by dabing on 15/10/23.
//  Copyright (c) 2015年 大兵布莱恩特. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<MHAsiNetworkDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

#pragma mark - MHAsiNetworkDelegate

- (void)requestDidFinishLoading:(NSDictionary *)returnData
{
    NSLog(@"-----%@",returnData);
}

- (void)requestdidFailWithError:(NSError *)error
{
    
}
#pragma mark - target
- (void)finishedRequest:(id)data didFaild:(NSError*)error
{
    NSLog(@"---%@-%@",data,error);
}

- (IBAction)block:(UIButton *)sender {
    
//      __weak typeof(self)weakSelf = self;
    
        [MHNetworkManager postReqeustWithURL:@"http://www.perasst.com:8081/perasst_v2/user/login.pa" params:@{@"userName":@"18538320461",@"password":@"123456"} successBlock:^(id returnData,int code,NSString *msg) {
    
            NSLog(@"----%@",returnData);
            
        } failureBlock:^(NSError *error) {
            
            NSLog(@"-----%@",error.localizedDescription);
            
        } showHUD:YES];
}

- (IBAction)delegate:(id)sender {
    
   [MHNetworkManager postReqeustWithURL:@"http://www.perasst.com:8081/perasst_v2/user/login.pa" params:@{@"userName":@"18538320461",@"password":@"123456"} delegate:self showHUD:YES];
}

- (IBAction)sel:(id)sender {
    
    [MHNetworkManager postReqeustWithURL:@"http://www.perasst.com:8081/perasst_v2/user/login.pa" params:@{@"userName":@"18538320461",@"password":@"123456"} target:self action:@selector(finishedRequest:didFaild:) showHUD:YES];
}

#pragma mark - 这里是为了测试多次发送请求时对于内存的压力 只要请求不超过100个同时 是不会闪退的 

-  (void)touchesBegan:(NSArray*)touches withEvent:(UIEvent *)event
{
   
    for (int i =0; i<30 ; i++) {
        
         [MHNetworkManager postReqeustWithURL:@"http://www.perasst.com:8081/perasst_v2/user/login.pa" params:@{@"userName":@"18538320461",@"password":@"123456"} target:self action:@selector(finishedRequest:didFaild:) showHUD:YES];
        
    }
    
    // 慎用 这个方法 block 方式可以实现所有的回调 delete target 会无法进行回调的 因为每个网络请求项都被在这里提前释放调了
    
//    [MHAsiNetworkHandler cancelAllNetItems];
    
}
@end
