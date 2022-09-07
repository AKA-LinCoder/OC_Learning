//
//  AddressBoolLoginVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/9/5.
//

#import "AddressBoolLoginVC.h"
#import "AddressBookListVC.h"
#import "MBProgressHUD.h"

@interface AddressBoolLoginVC ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UISwitch *keepPass;
@property (weak, nonatomic) IBOutlet UISwitch *autoLogin;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation AddressBoolLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"欢迎来到通讯录";
    [self.loginBtn setEnabled: NO];
    //从沙盒取出保存的设置
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    self.keepPass.on = [defaults boolForKey:@"keepPass"];
    self.autoLogin.on = [defaults boolForKey:@"autoLogin"];
    if(self.keepPass.on){
        self.userNameTextField.text = [defaults objectForKey:@"account"];
        self.passwordTextField.text = [defaults objectForKey:@"password"];
        if(self.autoLogin.on){
            //要自动登录
            [self loginButtonClick:self.loginBtn];
        }
    }
    
    
//    self.userNameTextField.delegate = self;
//    self.passwordTextField.delegate = self;
    [self.userNameTextField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    [self.passwordTextField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    //手动判断账号密码是否有值
    [self textChange];
}

-(void) textChange
{

    
    [self.loginBtn setEnabled:self.userNameTextField.text.length && self.passwordTextField.text.length];
}
- (IBAction)KeepPassword:(id)sender {
    //当没有选记住密码时，不能选自动登录
    if(self.keepPass.on == NO){
//        self.autoLogin.on = NO;
        [self.autoLogin setOn:NO animated:YES];
    }
}
- (IBAction)loginButtonClick:(id)sender {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"登录中";
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //判断账号密码是否正确
        if([self.userNameTextField.text isEqualToString:@"123"]&&[self.passwordTextField.text isEqualToString:@"123"]){
            //存储账号密码
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:self.userNameTextField.text forKey:@"account"];
            [defaults setObject:self.passwordTextField.text forKey:@"password"];
            [defaults setBool:self.autoLogin.on forKey:@"autoLogin"];
            [defaults setBool:self.keepPass.on forKey:@"keepPass"];
            //立马写入
            [defaults synchronize];
            
            
            
            
            AddressBookListVC *vc = [[AddressBookListVC alloc] init];
            vc.userName = self.userNameTextField.text;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            
        }
        [hud hideAnimated:YES];
    });
    
    
   
}
/*
 页面跳转
 [self performSegueWithIdentifier:@"123" sender:nil];
 底层实现
 到SB中有没有给定标识的segue
 根据指定标识，创建UIStoryboardSegue对象，把当前控制器设为源控制器，
 再去创建目标控制器 ，给目标控制器赋值
 调用当前控制器的prepareForSegue，告诉用户，当前的线已经准备好了
 调用[segue perfom];
    底层调用
 segue.sourceViewController.navigationController pushViewController:<#(nonnull UIViewController *)#> animated:<#(BOOL)#>
 */


//使用segue准备跳转前调用
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    //目标控制器
//    segue.destinationViewController;
   
}

- (IBAction)AutoLogin:(id)sender {
    if(self.autoLogin.on == YES){
        [self.keepPass setOn:YES animated:YES];
    }
}


//是否运行改变
//不能用于判断用户是否已经输入，因为这个方法会在输入第二个字符开始调用
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}


@end
