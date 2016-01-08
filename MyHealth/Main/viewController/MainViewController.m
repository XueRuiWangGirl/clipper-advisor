//
//  MainViewController.m
//  MyHealth
//
//  Created by 秦森 on 15/10/19.
//  Copyright © 2015年 秦森. All rights reserved.
//

#import "MainViewController.h"
#import "QHealthViewController.h"
#import "SettingViewController.h"
#import "RRunViewController.h"
#import "LslEatViewController.h"
#import "TabBarViewController.h"
#import "AchivmentViewController.h"
#import "SearchCollectionViewController.h"
#import "AsignViewController.h"

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UIButton *buttonHealth;
@property (weak, nonatomic) IBOutlet UIButton *buttonSetting;
@property (weak, nonatomic) IBOutlet UIButton *buttonRun;
@property (weak, nonatomic) IBOutlet UIButton *buttonEat;
@property (weak, nonatomic) IBOutlet UIButton *buttonOther;

@property (nonatomic,strong)AchivmentViewController *achiv;
@property (nonatomic,strong)SearchCollectionViewController *searchCv;
@property (nonatomic,strong)AsignViewController *asign;
@property (nonatomic,strong)NSArray *arr;

@end

@implementation MainViewController

- (void)viewDidLoad {
    self.title = @"My Health";
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [[self.navigationController.childViewControllers firstObject] view].hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonclick:(UIButton *)sender {
    
    switch (sender.tag) {
        case 1:
        {
            //Run
            RRunViewController *run_vc = [[RRunViewController alloc] initWithNibName:@"RRunViewController" bundle:nil];
            [self.navigationController pushViewController:run_vc animated:YES];
        }
            break;
            
        case 2:
        {
            //Eat
            LslEatViewController *eat_vc = [[LslEatViewController alloc]initWithNibName:@"LslEatViewController" bundle:nil];
            [self.navigationController pushViewController:eat_vc animated:YES];
        }
            break;

            
        case 3:
        {
            //Health
            QHealthViewController *health_vc = [[QHealthViewController alloc]initWithNibName:@"QHealthViewController" bundle:nil];
            
            [self.navigationController pushViewController:health_vc animated:YES];
        }
            break;

            
        case 4:
        {
            //other
            TabBarViewController *tabBar=[[TabBarViewController alloc]initWithNibName:@"TabBarViewController" bundle:nil];
            self.achiv=[[AchivmentViewController alloc]initWithNibName:@"AchivmentViewController" bundle:nil];
            
            self.searchCv=[[SearchCollectionViewController alloc]initWithNibName:@"SearchCollectionViewController" bundle:nil];
            
            self.asign=[[AsignViewController alloc]initWithNibName:@"AsignViewController" bundle:nil];
            
            self.arr=[NSArray arrayWithObjects:self.achiv,self.searchCv,self.asign ,nil];
            tabBar.viewControllers=self.arr;
            [self.navigationController  pushViewController:tabBar animated:YES];
        }
            break;
            
        case 5:
        {
            //Setting
            SettingViewController *cbcSet = [[SettingViewController alloc] initWithNibName:@"SettingViewController" bundle:nil];
            [self.navigationController pushViewController:cbcSet animated:YES];
        }
            break;

            
        default:
            break;
    }
    
    
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
