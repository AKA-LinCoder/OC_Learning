//
//  JSONDataShowVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/14.
//

#import "JSONDataShowVC.h"
#import "LinTimeMode.h"
#import "MJExtension.h"

@interface JSONDataShowVC ()
@property(nonatomic,strong)NSMutableArray *dicts;
@end

@implementation JSONDataShowVC
- (NSMutableArray *)dicts
{
    if(!_dicts){
        _dicts = [NSMutableArray array];
    }
    return _dicts;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self getDataFormNetWork];
   
}

-(void) getDataFormNetWork
{
    NSString *urlString = [@"http://192.168.0.148:8080/haha/app/workBench/getList" stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [@""dataUsingEncoding:NSUTF8StringEncoding];
    [request setValue:@"token" forHTTPHeaderField:@"token"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if(connectionError){
            return;
        }
//        NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
       //解析获取到的数据
       NSDictionary *dict =  [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];

        NSLog(@"%@",dict);

//        LinTimeMode *mode = [LinTimeMode timeWithDict:dict];
//        [self.dicts addObject:mode];
//        NSLog(@"dicts:%@",self.dicts);
        //替换
        [LinTimeMode mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                @"msg":@"message"
            };
        }];
        
        //字典转模型
        [self.dicts addObject: [LinTimeMode mj_objectWithKeyValues:dict]];

        
        NSLog(@"count:%lu",(unsigned long)self.dicts.count);
        [self.tableView reloadData];
        
        
    }];
    
    //
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.dicts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];

    }
    LinTimeMode *mode = self.dicts[indexPath.row];
    cell.textLabel.text = mode.msg;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
