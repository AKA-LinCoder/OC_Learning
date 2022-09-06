//
//  AddressBookUserItem.m
//  OC_Learning
//
//  Created by lsaac on 2022/9/6.
//

#import "AddressBookUserItem.h"

@implementation AddressBookUserItem
+ (instancetype)itemWithName:(NSString *)name phone:(NSString *)phone
{
    AddressBookUserItem *item =  [[AddressBookUserItem alloc] init];
    item.name = name;
    item.phone = phone;
    return item;
    
}
@end
