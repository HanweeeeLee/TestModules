//
//  PresentedFourViewController.m
//  ObjcBlockMemeryTest
//
//  Created by hanwe on 2021/03/11.
//

#import "PresentedFourViewController.h"
#import "PresentedFourPresenter.h"

@interface PresentedFourViewController () {
    PresentedFourPresenter *_myPresenter;
}

@property(copy)void(^completionHandler)(NSDictionary* result);
@end

@implementation PresentedFourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _myPresenter = [[PresentedFourPresenter alloc] init];
}
- (IBAction)closeAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
