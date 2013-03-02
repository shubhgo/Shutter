//
//  SGTeethView.m
//  Shutter
//
//  Created by Shubham Goel on 25/02/13.
//  Copyright (c) 2013 Shubham Goel. All rights reserved.
//

#import "SGTeethView.h"

@implementation SGTeethView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/* gradient */
- (void) drawRect:(CGRect)rect {
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    CGFloat colors[] =
    {
        0.0f, 0.0f, 0.0f, 1.0f,
        0.2f, 0.2f, 0.2f, 1.0f,
        0.8f, 0.8f, 0.8f, 1.0f,
    };
    CGGradientRef _gradientRef = CGGradientCreateWithColorComponents(rgb, colors, NULL, sizeof(colors) / (sizeof(colors[0]) * 4));
    CGColorSpaceRelease(rgb);

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGPoint start = rect.origin;
    start.x = rect.size.width;
    CGPoint end = CGPointMake(rect.origin.x, rect.size.height);
    CGContextDrawLinearGradient(context, _gradientRef, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    
    [super drawRect:rect];
}

@end
