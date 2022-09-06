//
//  AddressBookAddVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/9/5.
//

#import "AddressBookAddVC.h"
#import "AddressBookUserItem.h"


@interface AddressBookAddVC ()
@property (weak, nonatomic) IBOutlet UITextField *account;
@property (weak, nonatomic) IBOutlet UITextField *tel;
@property (weak, nonatomic) IBOutlet UIButton *add;


@end

@implementation AddressBookAddVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tel.keyboardType = UIKeyboardTypeNumberPad;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"添加";
    [self.account addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    [self.tel addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    [self textChange];
}
- (IBAction)addUser:(id)sender {
    AddressBookUserItem *item =  [AddressBookUserItem itemWithName:self.account.text phone:self.tel.text];
    self.listVC.userItem = item;
    [self.navigationController popViewControllerAnimated:YES];
}
-(void) textChange
{
    [self.add setEnabled:self.account.text.length&&self.tel.text.length];
}



@end
