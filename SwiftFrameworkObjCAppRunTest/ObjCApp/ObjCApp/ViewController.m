//
//  ViewController.m
//  ObjCApp
//
//  Created by hanwe lee on 2020/07/02.
//  Copyright © 2020 hanwe. All rights reserved.
//

#import "ViewController.h"
#import <SwiftFrameworkObjCAppRunTest/SwiftFrameworkObjCAppRunTest-Swift.h>
//#import "SwiftFrameworkObjCAppRunTest.h"



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MyClass *obj = [[MyClass alloc] init];
    [obj test];
    [obj addA:1 B:2];
    [obj addStringA:@"안녕" B:@"하시렵니까"];
    NSArray *arr1 = [[NSArray alloc] initWithObjects:@"1",@"2", nil];
    NSArray *arr2 = [[NSArray alloc] initWithObjects:@"3",@"4", nil];
    [obj mergeArrayA:arr1 B:arr2];
    [obj clousureTestIsSuccess:NO completeHandler:^{
        NSLog(@"성공");
    } failrueHanlder:^(NSError * err) {
        NSLog(@"실패:%ld",(long)err.code);
    }];
    
}


@end
