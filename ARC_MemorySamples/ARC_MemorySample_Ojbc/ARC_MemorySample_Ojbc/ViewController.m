//
//  ViewController.m
//  ARC_MemorySample_Ojbc
//
//  Created by hanwe lee on 2021/03/15.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak) NSData *myData;
@property (strong) NSDate *myData2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self strongRef];
//    NSLog(@"----");
//    [self weakRef];
//    NSLog(@"----");
//    [self unsafe_unretainedRef];
    [self autoReleasePool];
}

- (void)strongRef {
    id __strong obj1 = [[NSObject alloc] init];
    id __strong obj2 = obj1;
    NSLog(@"log1:%@",obj1);
    NSLog(@"log2:%@",obj2);
    obj1 = nil;
    NSLog(@"log3:%@",obj1);
    NSLog(@"log4:%@",obj2);
}

- (void)weakRef {
    id __strong obj1 = [[NSObject alloc] init];
    id __weak obj2 = obj1;
    NSLog(@"log1:%@",obj1);
    NSLog(@"log2:%@",obj2);
    obj1 = nil;
    NSLog(@"log3:%@",obj1);
    NSLog(@"log4:%@",obj2);
}

- (void)unsafe_unretainedRef {
    id __strong obj1 = [[NSObject alloc] init];
    id __unsafe_unretained obj2 = obj1;
    NSLog(@"log1:%@",obj1);
    NSLog(@"log2:%@",obj2);
    obj1 = nil;
    NSLog(@"log3:%@",obj1);
//    NSLog(@"log4:%@",obj2); //죽음
}

-(void)autoReleasePool {
    
    @autoreleasepool {
        id __strong obj1 = [[NSObject alloc] init];
        NSLog(@"log1:%@",obj1);
        /*
         오토릴리즈풀 안에 있기때문에 obj1은 오토릴리즈 풀에 등록이 된다.
         */
    }
    /*
     @autoreleasepool 블록을 벗어났기때문에 풀에 등록이 되어있는 객체는 자동릴리즈된다.
     */
}


@end
