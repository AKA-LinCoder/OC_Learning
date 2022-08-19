//
//  SuperClassAndClassVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/19.
//

#import "SuperClassAndClassVC.h"
#import "SubPerson.h"

@interface SuperClassAndClassVC ()

@end

@implementation SuperClassAndClassVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    SubPerson *sub = [[SubPerson alloc] init];
    [sub test];
    
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
