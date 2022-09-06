//
//  AddressBookListVC.h
//  OC_Learning
//
//  Created by lsaac on 2022/9/5.
//

#import <UIKit/UIKit.h>
#import "AddressBookUserItem.h"
NS_ASSUME_NONNULL_BEGIN

@interface AddressBookListVC : UITableViewController
@property(nonatomic,strong)NSString *userName;
@property(nonatomic,strong)AddressBookUserItem *userItem;
@end

NS_ASSUME_NONNULL_END
