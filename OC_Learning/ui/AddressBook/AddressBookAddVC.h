//
//  AddressBookAddVC.h
//  OC_Learning
//
//  Created by lsaac on 2022/9/5.
//

#import <UIKit/UIKit.h>
#import "AddressBookListVC.h"
NS_ASSUME_NONNULL_BEGIN

@class AddressBookAddVC,AddressBookUserItem;
@protocol AddressBookAddVCDelegate <NSObject>
//定义协议方法
-(void)addContactVC:(AddressBookAddVC *)addContactVC userItem:(AddressBookUserItem*)userItem;

@end
@interface AddressBookAddVC : UIViewController
@property(nonatomic,strong)AddressBookListVC *listVC;
@property(nonatomic,weak) id<AddressBookAddVCDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
