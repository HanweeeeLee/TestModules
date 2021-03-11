//
//  PresentedFourPresenter.h
//  ObjcBlockMemeryTest
//
//  Created by hanwe on 2021/03/11.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PresentedFourPresenter : NSObject
- (id)initWithView:(UIViewController *)viewController withCallback:(void (^)(NSDictionary *))result;
@end

NS_ASSUME_NONNULL_END
