

在归档时通常会在model里实现如下两个方法：

````
-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.gender forKey:@"gender"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super init];
    if (self) {
        
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.gender = [aDecoder decodeObjectForKey:@"gender"];
    }
    return self;
}
````

  此时，model只包含两个属性，现假设model有100个属性，难道需要在实现方法里一个一个的实现吗？ No,不需要！！！
可利用object-c的动态运行时机制，通过runtime实现归档及反归档，用runtime实现的另一个好处就是不用关心model属性的类型。接下来直接上代码：

````
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
````

通过这种方式，无须关心成员属性的个数及类型! Runtime是object-c的强大功能，期待你们的发现，好东西记得分享！
