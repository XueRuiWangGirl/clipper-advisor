#import "AchivmentViewController.h"
#import "OtherVIew.h"
#import "AppDelegate.h"
#import "RewardViewController.h"
@interface AchivmentViewController ()
@property (nonatomic,strong)UISegmentedControl *segC;
@property (nonatomic,strong)NSArray *arr;
@property (nonatomic,strong)OtherVIew *other_V;
@property (nonatomic,assign)int achivCount;
@property (weak, nonatomic) IBOutlet UIButton *rewardBtn;
@property (nonatomic,copy)NSString *steps;
@end


@implementation AchivmentViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.backgroundColor=[UIColor redColor];
    [self.view addSubview:self.segC];
    //添加otherView
    self.other_V=[[OtherVIew alloc]init];
    [self.view addSubview:self.other_V];
    //cache读取
    NSString *path=[[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"steps.plist"];
    self.steps=[[NSArray arrayWithContentsOfFile:path] firstObject];
    [self segClick:self.segC];
    
    //设置背景
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[[UIImage imageNamed:@"achiv.jpg"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]]];
    
}
-(NSArray *)arr
{
    if (!_arr) {
        _arr=[NSArray arrayWithObjects:@"今天斩获",@"成就小计", nil];
    }
    return _arr;
}
-(UISegmentedControl *)segC
{
    if (!_segC) {
        _segC=[[UISegmentedControl alloc]initWithItems:self.arr];
        [_segC setFrame:CGRectMake(55, 100, 300, 40)];
        _segC.selectedSegmentIndex=0;
        [_segC addTarget:self action:@selector(segClick:) forControlEvents:UIControlEventValueChanged];
        _segC.tintColor=[UIColor blackColor];
        
    }
    return _segC;
}
-(void)segClick:(UISegmentedControl *)seg
{
    switch (seg.selectedSegmentIndex) {
        case 0:{
            [self.other_V.StepLab removeFromSuperview];
            self.other_V.achivLab.font=[UIFont systemFontOfSize:45];
            NSString *showSteps=[self.steps stringByAppendingString:@"步"];
            self.other_V.achivLab.text=showSteps;
        }
            break;
        case 1:{
            //设置成就数显示
            self.achivCount=0;
            
            if (self.stepCount>10000) {
                self.achivCount++;
            }
            self.other_V.achivLab.text=[NSString stringWithFormat:@"%d",self.achivCount];
            self.other_V.achivLab.font=[UIFont systemFontOfSize:80];
            [self.other_V addSubview:self.other_V.StepLab];
            
           self.other_V.achivLab.text=[NSString stringWithFormat:@"%d",self.achivCount];
            
        }
            
            break;
            
        default:
            break;
    }
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeNavigationTitle" object:nil userInfo:@{@"myNavigationTitle" : @"个人成就"}];
}

- (IBAction)rewardClick:(id)sender {
    RewardViewController *rewardVc=[[RewardViewController alloc]init];
    [self.navigationController pushViewController:rewardVc animated:YES];
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
