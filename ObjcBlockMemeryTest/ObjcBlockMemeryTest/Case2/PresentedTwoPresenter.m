//
//  PresentedTwoPresenter.m
//  ObjcBlockMemeryTest
//
//  Created by hanwe on 2021/03/11.
//

#import "PresentedTwoPresenter.h"
#import <UIKit/UIKit.h>

@interface PresentedTwoPresenter() {
    NSData *_myData;
}
@end

@implementation PresentedTwoPresenter

- (id)init {
    
    self = [super init];
    
    if (self) {
        _myData = UIImagePNGRepresentation([UIImage imageNamed:@"heavyInAsset"]);
    }
    
    return self;
}
@end
