//
//  PresentedPresenter.m
//  ObjcBlockMemeryTest
//
//  Created by hanwe on 2021/03/11.
//

#import "PresentedPresenter.h"
#import <UIKit/UIKit.h>

@interface PresentedPresenter() {
    UIViewController *_parentsViewController;
    NSData *_myData;
}
@property(copy)void(^completionHandler)(NSDictionary* result);

@end

@implementation PresentedPresenter

- (id)initWithView:(UIViewController *)viewController withCallback:(void (^)(NSDictionary *))result {
    
    self = [super init];
    
    if (self) {
        self.completionHandler = result;
        _parentsViewController = viewController;
        _myData = UIImagePNGRepresentation([UIImage imageNamed:@"heavyInAsset"]);
    }
    
    return self;
}
@end
