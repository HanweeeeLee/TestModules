//
//  ViewController.m
//  ObjcBlockMemeryTest
//
//  Created by hanwe on 2021/03/11.
//

#import "ViewController.h"
#import "PresentedViewController.h"
#import "PresentedTwoViewController.h"
#import "PresentedThreeViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)test1Action:(id)sender {
    PresentedViewController *vc = [[PresentedViewController alloc] initWithNibName:@"PresentedViewController" bundle:nil];
    [self presentViewController:vc animated:YES completion:nil];
}
- (IBAction)test2Action:(id)sender {
    PresentedTwoViewController *vc = [[PresentedTwoViewController alloc] initWithNibName:@"PresentedTwoViewController" bundle:nil];
    [self presentViewController:vc animated:YES completion:nil];
}
- (IBAction)test3Action:(id)sender {
    PresentedThreeViewController *vc = [[PresentedThreeViewController alloc] initWithNibName:@"PresentedThreeViewController" bundle:nil];
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)test4Action:(id)sender {
    
}


@end
