//
//  NSCachesVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/11.
//

#import "NSCachesVC.h"

@interface NSCachesVC ()<NSCacheDelegate>

@property(nonatomic,strong) NSCache *cache;
@end

@implementation NSCachesVC

- (NSCache *)cache
{
    if(!_cache){
        _cache = [[NSCache alloc] init];
        //总成本数5，如果发现存的数据超过总成本，那么会自动回收之前的对象
        _cache.totalCostLimit = 8;
        _cache.delegate = self;
    }
    return _cache;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)addData:(id)sender {
    NSURL *url = [NSURL URLWithString:@"https://img2.baidu.com/it/u=46507371,2978896352&fm=253&fmt=auto&app=138&f=JPEG?w=333&h=499"];
    //如果data放在外面，就不会回收，因为key只是强引用，放在外面，存10次代表存的数据都是同一个，只是对这个data进行了10次引用，总成本是1
    NSData *data = [NSData dataWithContentsOfURL:url];
    for (NSInteger i = 0; i<10; i++) {
        //每循环一次，就是一个新的data，总成本是10
        NSData *data = [NSData dataWithContentsOfURL:url];
        //cost:成本，因为总成本为5，所以只会存最后5个数据
        [self.cache setObject:data forKey:@(i) cost:1];
    }
}

- (IBAction)checkData:(id)sender {
    for (NSInteger i = 0; i<10; i++) {
        NSData *data = [self.cache objectForKey:@(i)];
        if (data) {
            NSLog(@"查询到了数据");
        }
    }
}
- (IBAction)cleanData:(id)sender {
    for (NSInteger i = 0; i<10; i++) {
        [self.cache removeObjectForKey:@(i)];
    }
  
}
//字典与NSCache
//字典是拷贝的
//NSCache只是强引用，不存在拷贝

///即将回收时调用
- (void)cache:(NSCache *)cache willEvictObject:(id)obj
{
    NSLog(@"reback");
    NSLog(@"回收%zd",[obj length]);
}

@end
