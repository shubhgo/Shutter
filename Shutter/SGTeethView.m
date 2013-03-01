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

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGColorRef greyColor = [UIColor lightGrayColor].CGColor;
    CGColorRef blackColor = [UIColor blackColor].CGColor;

    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // fill with red
    CGContextSetFillColorWithColor(context, greyColor);
    CGContextFillRect(context, self.bounds);
    
    // stroke with black
    CGRect paperRect = self.bounds;
    CGContextSetStrokeColorWithColor(context, blackColor);
    CGContextSetLineWidth(context, 1.0);
    CGContextStrokeRect(context, paperRect);
}

@end
