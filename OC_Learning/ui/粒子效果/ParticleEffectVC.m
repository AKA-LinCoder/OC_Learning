//
//  ParticleEffectVC.m
//  OC_Learning
//
//  Created by Estim on 2022/9/17.
//

#import "ParticleEffectVC.h"
#import "VCCView.h"
@interface ParticleEffectVC ()
@property (strong, nonatomic) IBOutlet VCCView *vccView;

@end

@implementation ParticleEffectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)startR:(id)sender {
    [self.vccView start];
}

- (IBAction)reloadR:(id)sender {
    [self.vccView redraw];
}

@end
