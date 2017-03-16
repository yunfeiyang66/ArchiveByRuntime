//
//  Person.m
//  ArchiveByRuntime
//
//  Created by 云飞扬 on 17/3/14.
//  Copyright © 2017年 云飞扬. All rights reserved.
//

#import "Person.h"
#import <objc/message.h>

@implementation Person

- (void)encodeWithCoder:(NSCoder *)aCoder{
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([Person class], &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];// 取出成员属性
        const char *name = ivar_getName(ivar);
        NSString *key = [NSString stringWithUTF8String:name]; // 取出属性名称
        // kvc归档
        [aCoder encodeObject:[self valueForKey:key] forKey:key];
    }
    free(ivars);
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList([Person class], &count);
        for (int i = 0; i < count; i++) {
            Ivar ivar = ivars[i];// 取出成员属性
            const char *name = ivar_getName(ivar);
            NSString *key = [NSString stringWithUTF8String:name]; // 取出属性名称
            // kvc解档
           id value = [aDecoder decodeObjectForKey:key];
            [self setValue:value forKey:key];
        }
        free(ivars);
    }
    return self;
}

@end
