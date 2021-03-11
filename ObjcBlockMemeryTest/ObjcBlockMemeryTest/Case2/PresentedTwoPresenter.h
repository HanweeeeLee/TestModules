//
//  PresentedTwoPresenter.h
//  ObjcBlockMemeryTest
//
//  Created by hanwe on 2021/03/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MyDelegate
-(void)doSomething;

@end

@interface PresentedTwoPresenter : NSObject
@property (nonatomic, weak) id<MyDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
