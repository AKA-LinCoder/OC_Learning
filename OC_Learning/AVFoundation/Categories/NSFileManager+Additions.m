//
//  NSFileManager+Additions.m
//  OC_Learning
//
//  Created by lsaac on 2022/8/18.
//

#import "NSFileManager+Additions.h"

@implementation NSFileManager (Additions)
- (NSString *)temporaryDirectoryWithTemplateString:(NSString *)templateString {

    NSString *mkdTemplate =
        [NSTemporaryDirectory() stringByAppendingPathComponent:templateString];

    const char *templateCString = [mkdTemplate fileSystemRepresentation];
    char *buffer = (char *)malloc(strlen(templateCString) + 1);
    strcpy(buffer, templateCString);

    NSString *directoryPath = nil;

    char *result = mkdtemp(buffer);
    if (result) {
        directoryPath = [self stringWithFileSystemRepresentation:buffer
                                                          length:strlen(result)];
    }
    free(buffer);
    return directoryPath;
}

@end
