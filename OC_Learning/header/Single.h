//
//  Single.h
//  OC_Learning
//
//  Created by lsaac on 2022/8/10.
//

```objc
#define interfaceSingleton(name)  +(instancetype)share##name


#if __has_feature(objc_arc)
// ARC
#define implementationSingleton(name)  \
+ (instancetype)share##name \
{ \
name *instance = [[self alloc] init]; \
return instance; \
} \
static name *_instance = nil; \
+ (instancetype)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[super allocWithZone:zone] init]; \
}); \
return _instance; \
} \
- (id)copyWithZone:(NSZone *)zone{ \
return _instance; \
} \
- (id)mutableCopyWithZone:(NSZone *)zone \
{ \
return _instance; \
}
#else
// MRC

#define implementationSingleton(name)  \
+ (instancetype)share##name \
{ \
name *instance = [[self alloc] init]; \
return instance; \
} \
static name *_instance = nil; \
+ (instancetype)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[super allocWithZone:zone] init]; \
}); \
return _instance; \
} \
- (id)copyWithZone:(NSZone *)zone{ \
return _instance; \
} \
- (id)mutableCopyWithZone:(NSZone *)zone \
{ \
return _instance; \
} \
- (oneway void)release \
{ \
} \
- (instancetype)retain \
{ \
return _instance; \
} \
- (NSUInteger)retainCount \
{ \
return  MAXFLOAT; \
}
#endif

