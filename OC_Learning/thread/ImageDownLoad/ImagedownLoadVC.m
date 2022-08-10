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
@property(nonatomic,strong)NSOperationQueue *queue;
@property(nonatomic,strong)NSMutableDictionary *operations;
@end

@implementation ImagedownLoadVC
- (NSOperationQueue *)queue
{
    if (!_queue) {
        _queue = [[NSOperationQueue alloc] init];
        _queue.maxConcurrentOperationCount = 5;
    }
    return _queue;
}
- (NSMutableDictionary *)images
{
    if (!_images) {
        _images = [NSMutableDictionary dictionary];
    }
    return _images;
}
- (NSMutableDictionary *)operations
{
    if (!_operations) {
        _operations = [NSMutableDictionary dictionary];
    }
    return _operations;
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
- (void)didReceiveMemoryWarning
{
    //避免内存警告
    //不会影响当前显示的图片
    [self.images removeAllObjects];
    [self.queue cancelAllOperations];
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
    //3.图片不会刷新 reload
    //4.重复下载(手速过快，图片下载需要时间，图片还没下载完，就滑动又开启线程下载)
    //5.图片错乱：重用导致

    //先查看内存缓存中十分存在，不存在再查看磁盘缓存没有再下载
    UIImage *img = [self.images objectForKey:app.icon];
    if(img){
        cell.imageView.image = img;
        NSLog(@"使用旧图片");
    }else{
        //没有下载过
        //重新打开程序
        //检查磁盘缓存
        NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
        NSString *fileName = [app.icon lastPathComponent];
        NSString *fullPath = [caches stringByAppendingPathComponent:fileName];
        NSData *imageData = [NSData dataWithContentsOfFile:fullPath];
        if(imageData){
            UIImage *image = [UIImage imageWithData:imageData];
            cell.imageView.image = image;
            NSLog(@"使用磁盘图片");
            //把图片进行内存缓存
           [self.images setObject:image forKey:app.icon];
        }else{
    
            //检查该图片是否正在下载，如果是就不做操作，否则添加下载任务
            NSOperation *isDownLoading = [self.operations objectForKey:app.icon];
            if (isDownLoading) {
                
            }else{
                //解决重用导致的显示错乱
//                cell.imageView.image = nil; 显示nil影响用户体验，所以给个展位图
                cell.imageView.image = [UIImage imageNamed:@"people"];
                NSBlockOperation *download = [NSBlockOperation blockOperationWithBlock:^{
                    NSURL *url = [NSURL URLWithString:app.icon];
                    NSData *imageData = [NSData dataWithContentsOfURL:url];
                    
//                    //模拟网速慢
//                    [NSThread sleepForTimeInterval:2];
                    
                    UIImage *image = [UIImage imageWithData:imageData];
                    
                    //增加容错处理
                    if(!image){
                        //将操作移除操作字典，为了下一次到这里还能再次访问
                        [self.operations removeObjectForKey:app.icon];
                        return;
                    }
                    //把图片进行内存缓存
                   [self.images setObject:image forKey:app.icon];
                    //线程间通信
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                        
                        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
                        cell.imageView.image = image;
                                    }];
                   
                    NSLog(@"下载新图片");
                 
                    //把图片保存到Caches路径
                   
                    //写数据到磁盘
                    [imageData writeToFile:fullPath atomically:YES];
                    
                    //移除图片的下载操作
                    [self.operations removeObjectForKey:app.icon];
                }];
                
                //添加操作到操作缓存中
                [self.operations setObject:download forKey:app.icon];
                //添加操作到队列中
                [self.queue addOperation:download];
            }
            
           
           
        }
       
    }
    
    ///内存缓存---->磁盘缓存
    ///Document:会备份，不允许放缓存文件
    ///tmp:临时路径,随时被删除
    ///Library：
    ///     Caches：保存缓存文件，使用这个文件夹
    ///     Preferences:偏好设置，保存账号
  
    
 
    return cell;
}

@end
