//
//  SGShutterView.m
//  Shutter
//
//  Created by Shubham Goel on 15/02/13.
//  Copyright (c) 2013 Shubham Goel. All rights reserved.
//

#import "SGShutterView.h"
#import <QuartzCore/QuartzCore.h>
#import "SGTeethView.h"
#import "Common.h"

#define INNER_RADIUS 40.0f
#define OUTER_RADIUS 100.0f
#define TEETH_RADIUS 90.0f
#define NUMBER_OF_TEETH 6

@interface SGShutterView()
@property (nonatomic, strong) UIView *container;
@property float deltaAngle;
@property float totalRotation;
@end

@implementation SGShutterView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor blueColor];
        [self drawShutter];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void) drawShutter
{
    self.container = [[UIView alloc] initWithFrame:self.frame];
    CGFloat angleSize = 2*M_PI/NUMBER_OF_TEETH;
    CGPoint centerPoint = CGPointMake(_container.bounds.size.width/2.0-_container.frame.origin.x,
                                      _container.bounds.size.height/2.0-_container.frame.origin.y);
    self.totalRotation = 0.0;
    
    for (int i = 0; i < NUMBER_OF_TEETH; i++)
    {
        SGTeethView *tv = [[SGTeethView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 200.0f, 100.0f)];
        tv.layer.anchorPoint = CGPointMake(0.0f, 0.0f);
        tv.layer.position = [self positionForTeethAtIndex:i relativeToCenter:centerPoint];
        tv.transform = CGAffineTransformMakeRotation(angleSize*i + [self degreesToRadians:60.0]);
        tv.tag = i;
        [_container addSubview:tv];
        _container.userInteractionEnabled = NO;
    }
    [self addSubview:_container];
    UIImageView *bg = [[UIImageView alloc] initWithFrame:self.frame];
    bg.image = [UIImage imageNamed:@"frame.png"];
    [self addSubview:bg];
}

- (CGPoint) positionForTeethAtIndex:(int)index relativeToCenter:(CGPoint) center
{
    switch (index) {
        case 0:
            return (CGPointMake(center.x - TEETH_RADIUS, center.y));
            break;
        case 1:
        {
            CGFloat x = center.x - TEETH_RADIUS*cosf([self degreesToRadians:60.0]);
            CGFloat y = center.y - TEETH_RADIUS*sinf([self degreesToRadians:60.0]);
            return (CGPointMake(x, y));
        }
            break;
        case 2:
        {
            CGFloat x = center.x + TEETH_RADIUS*cosf([self degreesToRadians:60.0]);
            CGFloat y = center.y - TEETH_RADIUS*sinf([self degreesToRadians:60.0]);
            return (CGPointMake(x, y));
        }
            break;
        case 3:
        {
            return (CGPointMake(center.x + TEETH_RADIUS, center.y));
        }
            break;
        case 4:
        {
            CGFloat x = center.x + TEETH_RADIUS*cosf([self degreesToRadians:60.0]);
            CGFloat y = center.y + TEETH_RADIUS*sinf([self degreesToRadians:60.0]);
            return (CGPointMake(x, y));
        }
            break;
        case 5:
        {
            CGFloat x = center.x - TEETH_RADIUS*cosf([self degreesToRadians:60.0]);
            CGFloat y = center.y + TEETH_RADIUS*sinf([self degreesToRadians:60.0]);
            return (CGPointMake(x, y));
        }
            break;
        default:
            return (CGPointMake(center.x, center.y));
            break;
    }
}

- (CGFloat) degreesToRadians:(CGFloat) degrees
{
    return degrees * M_PI / 180;
}

- (CGFloat) radiansToDegrees:(CGFloat) radians
{
    return radians * 180 / M_PI;
}

- (float) calculateDistanceFromCenter:(CGPoint)point
{
    CGPoint center = CGPointMake(self.bounds.size.width/2.0f, self.bounds.size.height/2.0f);
	float dx = point.x - center.x;
	float dy = point.y - center.y;
	return sqrt(dx*dx + dy*dy);
}

#pragma mark - Touch Call Backs
- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchPoint = [touch locationInView:self];
    float dist = [self calculateDistanceFromCenter:touchPoint];
    
    if (dist < INNER_RADIUS || dist > OUTER_RADIUS)
    {
        // forcing a tap to be on the ferrule
        return NO;
    }
    
    float dx = touchPoint.x - self.container.center.x;
	float dy = touchPoint.y - self.container.center.y;
    self.deltaAngle = atan2(dy,dx);
    
    return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch*)touch withEvent:(UIEvent*)event
{
    CGPoint pt = [touch locationInView:self];
    float dx = pt.x  - self.container.center.x;
	float dy = pt.y  - self.container.center.y;
	float ang = atan2(dy,dx);
    float angleDifference = self.deltaAngle - ang;
    
    CGFloat angleSize = 2*M_PI/NUMBER_OF_TEETH;
    NSArray *views = [_container subviews];
    for (UIView *im in views)
    {
        
        NSLog(@"anchorPoint: image%i %f,%f ", im.tag, im.layer.anchorPoint.x, im.layer.anchorPoint.y);
//        im.layer.anchorPoint = CGPointMake(0.5f, 1.00f);
        im.transform = CGAffineTransformMakeRotation(angleDifference + im.tag*angleSize + _totalRotation + [self degreesToRadians:60.0]);
    }
    
    return YES;
}

- (void)endTrackingWithTouch:(UITouch*)touch withEvent:(UIEvent*)event
{
    CGPoint pt = [touch locationInView:self];
    float dx = pt.x  - self.container.center.x;
	float dy = pt.y  - self.container.center.y;
	float ang = atan2(dy,dx);
    float angleDifference = self.deltaAngle - ang;
    _totalRotation += angleDifference;
}

- (void)save
{
    NSLog(@"Save shutter image");
    
    NSArray *views = [_container subviews];
    for (UIView *im in views)
    {
        if (im.tag == 0)
        {
            UIImage *image = [Common imageFromView:im];
            [Common saveImageToDisk:image];
        }
    }
}
@end

// Diameter -116points