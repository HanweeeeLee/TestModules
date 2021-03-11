//
//  PresentedTwoViewController.m
//  ObjcBlockMemeryTest
//
//  Created by hanwe on 2021/03/11.
//

#import "PresentedTwoViewController.h"
#import "PresentedTwoPresenter.h"

@interface PresentedTwoViewController () {
    PresentedTwoPresenter *_myPresenter;
}

@end

@implementation PresentedTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _myPresenter = [[PresentedTwoPresenter alloc] init];
    _myPresenter.delegate = self;
}

- (IBAction)closeAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)doSomething {
    NSLog(@"do Something");
}

@end
