//
//  ImagedownLoadVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/10.
//

#import "ImagedownLoadVC.h"
#import "LinAPP.h"

@interface ImagedownLoadVC ()
@property(nonatomic,strong)NSArray *apps;
@property(nonatomic,strong)NSMutableDictionary *images;
@end

@implementation ImagedownLoadVC
- (NSMutableDictionary *)images
{
    if (!_images) {
        _images = [NSMutableDictionary dictionary];
    }
    return _images;
}
///懒加载
- (NSArray *)apps
{
    if(!_apps){
        //字典数组
        NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"apps.plist" ofType:nil]];
        NSLog(@"count:%lu",(unsigned long)array.count);
        //模型数组
        NSMutableArray *arrM = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            [arrM addObject:[LinAPP appWithDict:dict]];
        }
        _apps = arrM;
    }
    return _apps;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
   
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.apps.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    
    }
    LinAPP *app = self.apps[indexPath.row];
    cell.textLabel.text = app.name;
    cell.detailTextLabel.text = app.download;
    //最普通的方式，设置图片
//    NSURL *url = [NSURL URLWithString:app.icon];
//    NSData *imageData = [NSData dataWithContentsOfURL:url];
//    UIImage *image = [UIImage imageWithData:imageData];
//    cell.imageView.image = image;
    //存在问题
    //1.UI不流畅->开子线程
    //2.图片被重复下载 ->先把之前已经下载的图片保存起来用字典

    //先查看内存缓存中十分存在，不存在再下载
    UIImage *img = [self.images objectForKey:app.icon];
    if(img){
        cell.imageView.image = img;
        NSLog(@"使用旧图片");
    }else{
        NSURL *url = [NSURL URLWithString:app.icon];
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:imageData];
        cell.imageView.image = image;
        NSLog(@"下载新图片");
        //把图片进行保存
       [self.images setObject:image forKey:app.icon];
    }
  
    
 
    return cell;
}

@end
