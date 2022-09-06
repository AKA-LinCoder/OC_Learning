//
//  AddressBookUserItem.h
//  OC_Learning
//
//  Created by lsaac on 2022/9/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddressBookUserItem : NSObject

@property(nonatomic,strong)NSString *name;

@property(nonatomic,strong)NSString *phone;
+(instancetype)itemWithName:(NSString *) name phone:(NSString *) phone;
@end

NS_ASSUME_NONNULL_END
