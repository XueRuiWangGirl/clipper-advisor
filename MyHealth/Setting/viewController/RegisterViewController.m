//
//  RegisterViewController.m
//  MyHealth
//
//  Created by imac on 15/10/22.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "RegisterViewController.h"
#import "AllView.h"
#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height

@interface RegisterViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *allTextField;
@property (nonatomic, strong) UILabel *lableRight;
@property (nonatomic, strong) UILabel *lableRight1;
@property (nonatomic, strong) UILabel *lableRight2;
@property (nonatomic, strong) UIButton *register_button;
@property (nonatomic, strong) NSArray *arrayName;
@property (nonatomic, strong) NSArray *arrayImage;
@property (nonatomic, strong) NSString *string;
@property (nonatomic, strong) NSString *string2;
@property (nonatomic, strong) NSString *nameString;
@property (nonatomic, strong) NSMutableArray *array;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"注册";

    [self registerTextFiled];
    [self.view addSubview:self.register_button];
}
#pragma mark --- 初始化数组
/**
 *   初始化数组place
 *
 */
- (NSArray *)arrayName
{
    if (!_arrayName) {
        _arrayName = [NSArray arrayWithObjects:@"请输入用户名",@"请输入密码",@"请输入确认密码", nil];
    }
    return _arrayName;
}
/**
 *  初始化arraylable
 *
 */
- (NSArray *)arrayImage
{
    if (!_arrayImage) {
        _arrayImage = [NSArray arrayWithObjects:@"✅",@"❌", nil];
    }
    return _arrayImage;
}
- (NSMutableArray *)array
{
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
}
#pragma mark --  创建textFiled
/**
 *   注册在UIView上添加textfiled
 *
 */
- (void)registerTextFiled
{
    for (int i = 1; i<4; i++) {
        if (i == 1){
            _allTextField = [AllView UITextFiledFrame:CGRectMake(150, 160+(i-1)*65, 175, 35) andPlaceholder:self.arrayName[i-1] andAdjustsFont:YES andLayerWidth:0.5 andBorderColor:[UIColor blackColor]];
            _allTextField.tag += i;
            [self.view addSubview:self.allTextField];
            _allTextField.delegate = self;
        }else
        {
            _allTextField = [AllView UITextFiledFrame:CGRectMake(150, 160+(i-1)*65, 175, 35) andPlaceholder:self.arrayName[i-1] andAdjustsFont:YES andLayerWidth:0.5 andBorderColor:[UIColor blackColor]];
            _allTextField.tag += i;
            _allTextField.secureTextEntry = YES;
            [self.view addSubview:self.allTextField];
            _allTextField.delegate = self;
        }
    }
}

- (UILabel *)lableRight
{
    if (!_lableRight) {
    self.lableRight = [AllView UILableFrame:CGRectMake(335, 160, 40, 30) addBackgroundColor:[UIColor clearColor] andTitle:@""];
    }
    return _lableRight;
}
- (UILabel *)lableRight1
{
    if (!_lableRight1) {
        self.lableRight1 = [AllView UILableFrame:CGRectMake(335, 225, 40, 30) addBackgroundColor:[UIColor clearColor] andTitle:@""];
    }
    return _lableRight1;
}
- (UILabel *)lableRight2
{
    if (!_lableRight2) {
        self.lableRight2 = [AllView UILableFrame:CGRectMake(335, 290, 40, 30) addBackgroundColor:[UIColor clearColor] andTitle:@""];
    }
    return _lableRight2;
}

#pragma mark -- 键盘结束后判断输入是否正确；
- (void)textFieldDidEndEditing:(UITextField *)textField;
{
    switch (textField.tag) {
        case 1:
        {
            if (textField.text.length<6) {
            }
            else
            {
            self.nameString = textField.text;
            [self.lableRight removeFromSuperview];
            self.lableRight.text = self.arrayImage[0];
            [self.view addSubview:self.lableRight];
            }
            break;
        }
        case 2:
            if (textField.text.length<6) {
            }else
            {
                self.string = textField.text;
                [self.lableRight1 removeFromSuperview];
                self.lableRight1.text = self.arrayImage[0];
                [self.view addSubview:self.lableRight1];
            }
            break;
        case 3:
            if (![textField.text isEqualToString:self.string]) {
                
            }else
            {
                self.string2 = textField.text;
                [self.lableRight2 removeFromSuperview];
                self.lableRight2.text = self.arrayImage[0];
                [self.view addSubview:self.lableRight2];
            }
            break;
        default:
            break;
    }
}

/**
 *  取消键盘第一响应者
 *
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (UIButton *)register_button
{
    if (!_register_button) {
        _register_button = [AllView UIButtonFrame:CGRectMake(150, 405, 85, 50) andBackgroundColor:[UIColor colorWithRed:100/255.0 green:200/255.0 blue:25/255.0 alpha:0.8] andTitle:@"立即注册" andTitleColor:[UIColor blackColor]];
        _register_button.layer.borderColor = [[UIColor colorWithRed:100/255.0 green:200/255.0 blue:25/255.0 alpha:0.8] CGColor];
        _register_button.layer.cornerRadius = 15;
        [self.register_button addTarget:self action:@selector(clickRegister:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _register_button;
}

- (void)clickRegister:(UIButton *)btn
{
    if (self.nameString.length<6) {
        [self.lableRight removeFromSuperview];
        self.lableRight.text = self.arrayImage[1];
        [self.view addSubview:self.lableRight];
    }else if (self.string.length<6)
    {
        [self.lableRight1 removeFromSuperview];
        self.lableRight1.text = self.arrayImage[1];
        [self.view addSubview:self.lableRight1];
    }else if (![self.string isEqualToString:self.string2])
    {
        [self.lableRight2 removeFromSuperview];
        self.lableRight2.text = self.arrayImage[1];
        [self.view addSubview:self.lableRight2];
    }else
    {
        NSArray *arrayPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *path = [arrayPath[0] stringByAppendingString:@"name.plist"];
        self.array = [NSMutableArray arrayWithContentsOfFile:path];
        NSDictionary *dic = [NSDictionary dictionaryWithObject:self.string forKey:self.nameString];
        [self.array addObject:dic];
        [self.array writeToFile:path atomically:YES];
        [self clickBack];
    }
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];

}

- (void) clickBack
{
    [self.navigationController popViewControllerAnimated:YES];
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
