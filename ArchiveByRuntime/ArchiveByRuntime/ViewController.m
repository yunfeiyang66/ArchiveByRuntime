//
//  ViewController.m
//  ArchiveByRuntime
//
//  Created by 云飞扬 on 17/3/14.
//  Copyright © 2017年 云飞扬. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)archiveAction:(id)sender {
    
    Person *person = [[Person alloc] init];
    person.name = @"Jack";
    person.age = 18;
    
    // 保存一个临时文件
    NSString *tempPath = NSTemporaryDirectory();
    NSString *filePath = [tempPath stringByAppendingPathComponent:@"Person"];
    
    // 归档
    [NSKeyedArchiver archiveRootObject:person toFile:filePath];
    
}
- (IBAction)unArchiveAction:(id)sender {
    
    // 保存一个临时文件
    NSString *tempPath = NSTemporaryDirectory();
    NSString *filePath = [tempPath stringByAppendingPathComponent:@"Person"];
    
    // 解档
    Person *person = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    NSLog(@"%@ %d",person.name,person.age);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
