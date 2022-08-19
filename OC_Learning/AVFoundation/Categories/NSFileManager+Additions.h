//
//  NSFileManager+Additions.h
//  OC_Learning
//
//  Created by lsaac on 2022/8/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSFileManager (Additions)
- (NSString *)temporaryDirectoryWithTemplateString:(NSString *)templateString;
@end

NS_ASSUME_NONNULL_END
