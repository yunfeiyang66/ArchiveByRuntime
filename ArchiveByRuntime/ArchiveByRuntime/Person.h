//
//  Person.h
//  ArchiveByRuntime
//
//  Created by 云飞扬 on 17/3/14.
//  Copyright © 2017年 云飞扬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject<NSCoding>

@property (nonatomic,strong)NSString *name;
@property (nonatomic,assign)int age;

@end
