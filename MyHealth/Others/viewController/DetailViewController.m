//
//  DetailViewController.m
//  MyHealth
//
//  Created by imac on 15/11/11.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "DetailViewController.h"
#import "Deal.h"
#import "DPRequest.h"
#import "DPAPI.h"
@interface DetailViewController ()<UIWebViewDelegate,DPRequestDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 加载网页
    self.webView.hidden = YES;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.deal.deal_h5_url]]];
    // 发送请求获得更详细的团购数据
    DPAPI *api = [[DPAPI alloc] init];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    UIBarButtonItem *back=[[UIBarButtonItem alloc]initWithTitle:@"back" style:UIBarButtonItemStyleDone target:self action:@selector(backClick)];
   
    self.navigationItem.leftBarButtonItem=back;
    params[@"deal_id"] = self.deal.deal_id;
    [api requestWithURL:@"v1/deal/get_single_deal" params:params delegate:self];

    // Do any additional setup after loading the view from its nib.
}
#pragma mark-backClick
-(void)backClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - DPRequestDelegate
- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    NSLog(@"详情 == %@",result);
    self.deal = [Deal objectWithKeyValues:[result[@"deals"] firstObject]];
}
- (void)request:(DPRequest *)request didFailWithError:(NSError *)error
{
    [MBProgressHUD showError:@"网络繁忙,请稍后再试" toView:self.view];
}
#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"地址===%@",webView.request.URL);
    //http://m.dianping.com/tuan/deal/13891790
    //http://m.dianping.com/tuan/deal/moreinfo/13891790
    //absoluteString将URL地址转换成字符串
    //NSLog(@"ID===%@",self.deal.deal_id);
    if ([webView.request.URL.absoluteString isEqualToString:self.deal.deal_h5_url]) {
        // 旧的HTML5页面加载完毕
        
        NSString *ID = [self.deal.deal_id substringFromIndex:[self.deal.deal_id rangeOfString:@"-"].location + 1];
        NSString *urlStr = [NSString stringWithFormat:@"http://lite.m.dianping.com/group/deal/moreinfo/%@", ID];
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
    } else { // 详情页面加载完毕
        // 用来拼接所有的JS
        NSMutableString *js = [NSMutableString string];
        // 删除header
        [js appendString:@"var header = document.getElementsByTagName('header')[0];"];
        [js appendString:@"header.parentNode.removeChild(header);"];
        // 删除顶部的购买
        [js appendString:@"var box = document.getElementsByClassName('cost-box')[0];"];
        [js appendString:@"box.parentNode.removeChild(box);"];
        // 删除底部的购买
        [js appendString:@"var buyNow = document.getElementsByClassName('buy-now')[0];"];
        [js appendString:@"buyNow.parentNode.removeChild(buyNow);"];
        
        //利用webView执行JS
        [webView stringByEvaluatingJavaScriptFromString:js];
        
        // 获得页面
//        NSString *html = [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('html')[0].outerHTML;"];
        //NSLog(@"html=====%@",html);
        // 显示webView
        webView.hidden = NO;
        //        // 隐藏正在加载
        [self.loadingView stopAnimating];
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //    NSLog(@"%@ %@", self.deal.deal_id,request.URL);
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
