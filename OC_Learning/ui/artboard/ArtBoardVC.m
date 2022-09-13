//
//  ArtBoardVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/9/13.
//

#import "ArtBoardVC.h"
#import "Canvas.h"

@interface ArtBoardVC ()<UIToolbarDelegate>
@property(nonatomic,strong)UIToolbar *toolbar;
//@property(nonatomic,strong)UIView *bottomView;
@property(nonatomic,strong)UIView *mainView;
@property(nonatomic,strong)UIButton *yellowBtn;
@property(nonatomic,strong)UIButton *blueBtn;
@property(nonatomic,strong)UIButton *orangeBtn;
@property(nonatomic,strong)UISlider *slider;
@property(nonatomic,strong) Canvas *canvas;
@end

@implementation ArtBoardVC
- (Canvas *)canvas
{
    if(_canvas==nil){
        _canvas = [[Canvas alloc] init];
        _canvas.frame = self.view.frame;
        _canvas.backgroundColor = [UIColor whiteColor];
    }
    return _canvas;
}
- (UISlider *)slider{
    if (_slider==nil) {
        _slider = [[UISlider alloc] init];
        _slider.minimumValue = 1;
        _slider.maximumValue = 10;
        [_slider addTarget:self action:@selector(setLineWidth:) forControlEvents:UIControlEventValueChanged];
    }
    return _slider;
}

- (UIButton *)yellowBtn{
    if(_yellowBtn==nil){
        _yellowBtn = [[UIButton alloc] init];
        _yellowBtn.backgroundColor = [UIColor yellowColor];
        _yellowBtn.layer.borderWidth = 1;
        _yellowBtn.tag = 0;
        [_yellowBtn addTarget:self action:@selector(setLineColor:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _yellowBtn;
}

- (UIButton *)blueBtn{
    if (_blueBtn==nil) {
        _blueBtn = [[UIButton alloc] init];
        _blueBtn.backgroundColor = [UIColor blueColor];
        _blueBtn.layer.borderWidth = 1;
        _blueBtn.tag = 1;
        [_blueBtn addTarget:self action:@selector(setLineColor:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _blueBtn;
}

- (UIButton *)orangeBtn
{
    if(_orangeBtn==nil){
        _orangeBtn = [[UIButton alloc] init];
        _orangeBtn.backgroundColor = [UIColor orangeColor];
        _orangeBtn.layer.borderWidth = 1;
        _orangeBtn.tag = 2;
        [_orangeBtn addTarget:self action:@selector(setLineColor:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _orangeBtn;
}


- (UIToolbar *)toolbar
{
    if (_toolbar==nil) {
        _toolbar = [[UIToolbar alloc] init];
        _toolbar.delegate = self;
        _toolbar.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:self.toolbar];
//        bookTextView.leadingAnchor.constraintEqualToAnchor(
//                     view.readableContentGuide.leadingAnchor).active = true
//        bookTextView.trailingAnchor.constraintEqualToAnchor(
//                     view.readableContentGuide.trailingAnchor).active = true
        [[_toolbar.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor] setActive:YES];
        [[_toolbar.trailingAnchor constraintEqualToAnchor:self.view.readableContentGuide.trailingAnchor ] setActive:YES];
        [[_toolbar.leadingAnchor constraintEqualToAnchor:self.view.readableContentGuide.leadingAnchor ] setActive:YES];
        [[_toolbar.heightAnchor constraintEqualToConstant:50] setActive:YES];
//        [[_toolbar.widthAnchor constraintEqualToConstant:self.view.frame.size.width] setActive:YES];
    }
    return _toolbar;
}

- (UIView *)mainView
{
    if (_mainView==nil) {
        _mainView = [[UIView alloc] init];
        _mainView.backgroundColor = [UIColor orangeColor];
        _mainView.frame = CGRectMake(0, 140, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-91);
    }
    return _mainView;
}
//- (UIView *)bottomView
//{
//    if(_bottomView==nil){
//        _bottomView = [[UIView alloc] init];
//        _bottomView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-91, [UIScreen mainScreen].bounds.size.width, 300);
//        _bottomView.backgroundColor = [UIColor grayColor];
//
//
////        [_bottomView addSubview:stack];
//
//
//    }
//    return _bottomView;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.canvas];
    self.view.backgroundColor = [UIColor whiteColor];
   
//    [self.view addSubview:self.mainView];
//    [self.view addSubview:self.bottomView];
    [self setupToolBarUI];
    [self setupLayout];
    
}



-(void)setupToolBarUI
{
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"清屏" style:UIBarButtonItemStylePlain target:self action:@selector(cleanBoard)];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithTitle:@"撤销" style:UIBarButtonItemStylePlain target:self action:@selector(reback)];
    UIBarButtonItem *item3 = [[UIBarButtonItem alloc] initWithTitle:@"橡皮擦" style:UIBarButtonItemStylePlain target:self action:@selector(eraser)];
    UIBarButtonItem *item4 = [[UIBarButtonItem alloc] initWithTitle:@"照片" style:UIBarButtonItemStylePlain target:self action:@selector(selectFromPhotoAlbum)];
    UIBarButtonItem *item5 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemFlexibleSpace) target:self action:nil];
    UIBarButtonItem *item6 = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveToPhotoAlbum)];
    [self.toolbar setItems:@[item1,item2,item3,item4,item5,item6] animated:YES];
}

//布局下面部分
-(void) setupLayout
{
    UIStackView *colorStackView = [[UIStackView alloc ] initWithArrangedSubviews:@[
        self.yellowBtn,self.blueBtn,self.orangeBtn]];
    colorStackView.distribution = UIStackViewDistributionFillEqually;
    UIStackView *stackView = [[UIStackView alloc ] initWithArrangedSubviews:@[
        colorStackView,self.slider]];
    stackView.spacing = 12;
    stackView.distribution = UIStackViewDistributionFillEqually;
    [self.view addSubview:stackView];
    stackView.translatesAutoresizingMaskIntoConstraints = NO;
    [[stackView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor] setActive:YES];
    [[stackView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor] setActive:YES];
    [[stackView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-8] setActive:YES];
}

-(void)cleanBoard
{
    [self.canvas clean];
}

/// 撤销
-(void)reback
{
    [self.canvas reback];
}

/// 橡皮擦
-(void)eraser
{
    [self.canvas eraser];
}

-(void) setLineWidth:(UISlider *)slider
{
    [self.canvas setLineWidth:slider.value];
}

-(void) setLineColor:(UIButton *)button
{
    UIColor *color = [UIColor blackColor];
    if(button.tag==0){
        color = [UIColor yellowColor];
    }else if (button.tag == 1){
        color = [UIColor blueColor];
    }else if (button.tag == 2){
        color = [UIColor orangeColor];
    }else{
        
    }
    [self.canvas setLineColor:color];
}


/// 从相册选中照片
-(void)selectFromPhotoAlbum
{
    
}


/// 保存到相册
-(void)saveToPhotoAlbum
{
    //开启上下文
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, 0);
    //获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //把画板上的内容渲染到上下文中
    [self.canvas.layer renderInContext:context];
    
    
    //从上下文获取图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();
    //把图片保存到系统相册中
    UIImageWriteToSavedPhotosAlbum(newImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}
//保存完毕时调用
  - (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSLog(@"%s",__func__);
}



@end
