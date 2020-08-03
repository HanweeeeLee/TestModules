//
//  HWGradationView.m
//  HWGradationView
//
//  Created by hanwe on 2018. 5. 17..
//  Copyright © 2018년 hanwe. All rights reserved.
//

#import "HWGradationView.h"

@implementation HWGradationView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    _gradientLayer = [CAGradientLayer layer];
    _gradientLayer.colors = @[(id)[NSColor colorWithDeviceWhite:0.75 alpha:1.0].CGColor,
                              (id)[NSColor colorWithRed:1 green:1 blue:0 alpha:1.0].CGColor
                              ];
    _gradientLayer.anchorPoint = CGPointMake(0, 0);
    _gradientLayer.frame = self.bounds;
    NSLog(@"_gradientLa :%f %f %f %f",_gradientLayer.frame.origin.x,_gradientLayer.frame.origin.y,_gradientLayer.frame.size.width,_gradientLayer.frame.size.height);
    [_gradientLayer setStartPoint:CGPointMake(0.0, 0.75)];
    [self.layer addSublayer:_gradientLayer];

    
    // Drawing code here.
}

@end
