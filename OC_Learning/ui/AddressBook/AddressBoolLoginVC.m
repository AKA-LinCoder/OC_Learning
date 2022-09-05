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
            AddressBookListVC *vc = [[AddressBookListVC alloc] init];
            vc.userName = self.userNameTextField.text;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            
        }
        [hud hideAnimated:YES];
    });
    
    
   
}
//使用segue
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
