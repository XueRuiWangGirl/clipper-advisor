//
//  CBCViewController.m
//  MyHealth
//
//  Created by imac on 15/10/22.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "CBCViewController.h"
#import "RegisterViewController.h"
#import "SetTableViewCell.h"
#import "AllView.h"

@interface CBCViewController ()<UITextFieldDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) UITextField *login_tf;
@property (nonatomic, strong) UITextField *register_tf;
@property (nonatomic, strong) UILabel *login_label;
@property (nonatomic, strong) UILabel *register_label;
@property (nonatomic, strong) UIButton *login_button;
@property (nonatomic, strong) UIButton *register_button;
@property (nonatomic, strong) UIButton *search_button;
@property (nonatomic, strong) NSDictionary *dicName;
@property (nonatomic, strong) NSMutableArray *keyArray;
@property (nonatomic, strong) NSMutableArray *objectArray;
@property (nonatomic, strong) UIAlertView *alert;
@property (nonatomic, strong) UIAlertView *alert1;

@end

@implementation CBCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"登录";

    NSArray *arrayPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = [arrayPath[0] stringByAppendingString:@"name.plist"];
    self.dicName = nil;
    NSArray *arr = [NSArray arrayWithContentsOfFile:path];
    [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        self.dicName = obj;
       [self.keyArray addObjectsFromArray:self.dicName.allKeys ];
        [self.objectArray addObjectsFromArray:self.dicName.allValues];
    }];
    
    self.view.backgroundColor = [UIColor colorWithRed:90/255.0f green:250/255.0f blue:197/255.0f alpha:1];
    [self addAllUIView];
    
}
#pragma mark -- 将UIButton，UITextfiled等subview在UIview上
- (void)addAllUIView
{
    [self.view addSubview:self.login_tf];
    [self.view addSubview:self.register_tf];
    [self.view addSubview:self.login_button];
    [self.view addSubview:self.register_button];
    [self.view addSubview:self.search_button];
}
- (UIAlertView *)alert
{
    if (!_alert) {
        _alert = [[UIAlertView alloc] initWithTitle:@"错误" message:@"用户名不正确" delegate:self cancelButtonTitle:@"取消" otherButtonTitles: nil];
    }
    return _alert;
}
- (UIAlertView *)alert1
{
    if (!_alert1) {
        _alert1 = [[UIAlertView alloc] initWithTitle:@"错误" message:@"密码不正确" delegate:self cancelButtonTitle:@"取消" otherButtonTitles: nil];
    }
    return _alert1;
}
- (NSMutableArray *)keyArray
{
    if (!_keyArray) {
        _keyArray = [NSMutableArray array];
    }
    return _keyArray;
}
- (NSMutableArray *)objectArray
{
    if (!_objectArray) {
        _objectArray = [NSMutableArray array];
    }
    return _objectArray;
}
#pragma mark --- addsubview:(UIView)
/**
 *  初始化一些textfiled，button在uiview上
 *
 *  @return 返回一些textfiled，button
 */
- (UITextField *)login_tf
{
    if (!_login_tf) {
        _login_tf = [AllView UITextFiledFrame:CGRectMake(90, 250, 240, 40) andPlaceholder:@"请输入用户名" andAdjustsFont:YES andLayerWidth:0.5 andBorderColor:[UIColor blackColor]];
        _login_tf.tag = 10;
        _login_tf.clearButtonMode = UITextFieldViewModeWhileEditing;
        _login_tf.delegate = self;
        
    }
    return _login_tf;
}
- (UITextField *)register_tf
{
    if (!_register_tf) {
        _register_tf = [[UITextField alloc] initWithFrame:CGRectMake(90, 320, 240, 40)];
        _register_tf.secureTextEntry = YES;
        _register_tf.placeholder = @"请输入密码";
        _login_tf.clearButtonMode = UITextFieldViewModeWhileEditing;
        _register_tf.adjustsFontSizeToFitWidth = YES;
        _register_tf.layer.borderWidth = 0.5;
        _register_tf.tag = 101;
        _register_tf.layer.borderColor = [[UIColor blackColor] CGColor];
        _register_tf.delegate = self;

    }
    return _register_tf;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    CGRect newRect = self.view.frame;
    newRect.origin.y = 0;
    [UIView animateWithDuration:0.25 animations:^{
        self.view.frame = newRect;
    }];
    return YES;
}
- (UIButton *)login_button
{
    if (!_login_button) {
        _login_button = [AllView UIButtonFrame:CGRectMake(80, 405, 80, 40) andBackgroundColor:[UIColor colorWithRed:100/255.0 green:200/255.0 blue:25/255.0 alpha:0.8] andTitle:@"登录" andTitleColor:[UIColor whiteColor]];
        [self.login_button addTarget:self action:@selector(clickLogin:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _login_button;
}
- (UIButton *)register_button
{
    if (!_register_button) {
        _register_button = [AllView UIButtonFrame:CGRectMake(250, 405, 80, 40) andBackgroundColor:[UIColor colorWithRed:100/255.0 green:200/255.0 blue:25/255.0 alpha:0.8] andTitle:@"注册" andTitleColor:[UIColor whiteColor]];
        [_register_button addTarget:self action:@selector(clickRegister:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _register_button;
}
- (UIButton *)search_button
{
    if (!_search_button) {
        
        _search_button = [AllView UIButtonFrame:CGRectMake(255, 510, 120, 40) andBackgroundColor:[UIColor whiteColor] andTitle:@"找回密码 ?" andTitleColor:[UIColor blackColor]];
        _search_button.backgroundColor = [UIColor clearColor];
        [_search_button addTarget:self action:@selector(clickSearch:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _search_button;
}
#pragma mark - - 登录按钮的跳转
- (void)clickLogin:(UIButton *)login
{
   
    if ([self.keyArray containsObject:self.login_tf.text]) {
        if ([self.objectArray containsObject:self.register_tf.text]) {
            NSArray *arrayPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
            NSString *path = [arrayPath[0] stringByAppendingPathComponent:@"Value.plist"];
            NSArray *arrayValue = [NSArray arrayWithObjects:self.login_tf.text,@"一个神奇而伟大的人",@"userNameImage", nil];
            [arrayValue writeToFile:path atomically:YES];

            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            [self.alert1 show];
        }
    }
    else
        [self.alert show];

}
- (void)clickRegister:(UIButton *)registe
{
    RegisterViewController *register_vc = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
    [self.navigationController pushViewController:register_vc animated:YES];
}
#pragma mark - - 找回密码按钮跳转
- (void)clickSearch:(UIButton *)search
{
    
}
/**
 *  当页面将要出现时将navigation隐藏属性设为no
 *
 *  @param animated 添加返回主页按钮
 */
- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
//返回主页
- (void) clickBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - - 验证用户名和密码

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect newRect = self.view.frame;
    newRect.origin.y = -150;
    [UIView animateWithDuration:0.5 animations:^{
        self.view.frame = newRect;
    }];
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
