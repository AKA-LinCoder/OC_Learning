//
//  XMLVC.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/14.
//

#import "XMLVC.h"

@interface XMLVC ()<NSXMLParserDelegate>

@end

@implementation XMLVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    [self native];
    //解析XML文件的方式
    //1.DOM 利用DOM，一次性将整个XML文档加载进内存，适合小文件
    //2.SAX:从根元素开始，按顺序一个元素一个元素的解析，适合大文件
    
    //NSXMLParser:SAX方式
    //GDataXML:DOM 方式，基于libxml2
}

-(void)native
{
    //1.解析数据，创建XML解析器：SAX
    
    //不知道为什么，用data无法解析
    //    NSData *data = [[NSData alloc] initWithContentsOfFile:@"local.xml"];
    NSString *pathFile = [[NSBundle mainBundle] bundlePath];
    NSString *path = [[NSString alloc] initWithString:[pathFile stringByAppendingPathComponent:@"local.xml"]];
    NSURL *xmlURL = [NSURL fileURLWithPath:path];
    NSXMLParser *parser = [[ NSXMLParser alloc] initWithContentsOfURL:xmlURL];
    
    //    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    //设置代理
    parser.delegate = self;
    //开始解析,阻塞，只有执行完才会继续执行
    [parser parse];
}

#pragma mark-NSXMLParserDelegate
//开始解析元素
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict
{
    NSLog(@"%s",__func__);
    //过滤根元素
    if([elementName isEqualToString:@"users"]){
        return;
    }
}

//某个元素解析完毕
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    NSLog(@"%s",__func__);
}

//开始解析
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    NSLog(@"%s",__func__);
}
//结束解析
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    NSLog(@"%s",__func__);
}
@end
