//
//  PresentedViewController.m
//  ObjcBlockMemeryTest
//
//  Created by hanwe on 2021/03/11.
//

#import "PresentedViewController.h"
#import "PresentedPresenter.h"

@interface PresentedViewController () {
    PresentedPresenter *_myPresenter;
}
@property(copy)void(^completionHandler)(NSDictionary* result);
@end

@implementation PresentedViewController

- (void)onReceiveWithResult:(void (^)(NSDictionary *))result {
    
    self.completionHandler = result;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _myPresenter = [[PresentedPresenter alloc] initWithView:self withCallback:self.completionHandler];
}

- (IBAction)closeAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
