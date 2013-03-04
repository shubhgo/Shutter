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
@property (nonatomic, assign) NSRange teethRotationRange;//degrees
@property (nonatomic, assign) NSInteger wheelRotationRange;//degrees
@property (nonatomic, strong) NSArray *stagesArray;
@property (nonatomic, strong) UIView *container;
@property float teethStartingAngle;//radians
@property float wheelStartAngle;//radians
@property float totalRotation;//radians
@property float teethRotationFactor;//ratio
@end

@implementation SGShutterView

- (id)  initWithFrame:(CGRect)frame
   teethRotationRange:(NSRange)teethRotationRange
   wheelRotationRange:(NSInteger)wheelRotationRange
           stageArray:(NSArray *)stagesArray
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _teethRotationRange = teethRotationRange;
        _wheelRotationRange = wheelRotationRange;
        _stagesArray = stagesArray;
        _teethStartingAngle = [self degreesToRadians:((float) teethRotationRange.location)];
        _teethRotationFactor = (float)teethRotationRange.length/(float)wheelRotationRange;
        UIColor *greyColor = [UIColor colorWithWhite:0.349 alpha:1.000];
        self.backgroundColor = greyColor;
        [self drawShutter];
    }
    return self;
}

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

- (void) addMask
{
    CGMutablePathRef circularPath = CGPathCreateMutable();
    CGPathMoveToPoint(circularPath, NULL, self.center.x, self.center.y);
    CGPathAddArc(circularPath, NULL, self.center.x, self.center.y, TEETH_RADIUS, 0, [self degreesToRadians:360.0], YES);
    CGPathCloseSubpath(circularPath);
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    [maskLayer setPath:circularPath];
    CGPathRelease(circularPath);
    self.layer.mask = maskLayer;
}

- (void) drawShutter
{
    self.container = [[UIView alloc] initWithFrame:self.frame];
    CGFloat angleSize = 2*M_PI/NUMBER_OF_TEETH; // radians
    CGPoint centerPoint = CGPointMake(_container.bounds.size.width/2.0-_container.frame.origin.x,
                                      _container.bounds.size.height/2.0-_container.frame.origin.y);
    self.totalRotation = 0.0;
    
    for (int i = 0; i < NUMBER_OF_TEETH; i++)
    {
        SGTeethView *tv = [[SGTeethView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 200.0f, 100.0f)];
        tv.layer.anchorPoint = CGPointMake(0.0f, 0.0f);
        tv.layer.position = [self positionForTeethAtIndex:i relativeToCenter:centerPoint];
        tv.transform = CGAffineTransformMakeRotation(angleSize*i + _teethStartingAngle);
        tv.tag = i;
        if (i == 5)
        {
            float theta = _teethStartingAngle;
            CAShapeLayer *maskLayer = [self maskLayerFor6thPetalWithTheta:[self radiansToDegrees:theta]];
            tv.layer.mask = maskLayer;
        }
        if (i == 4)
        {
            float theta = _teethStartingAngle;
            CAShapeLayer *maskLayer = [self maskLayerFor5thPetalWithTheta:[self radiansToDegrees:theta]];
            tv.layer.mask = maskLayer;
        }

        [_container addSubview:tv];
        _container.userInteractionEnabled = NO;
    }
    [self addSubview:_container];
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
        return NO;
    }
    
    float dx = touchPoint.x - self.container.center.x;
	float dy = touchPoint.y - self.container.center.y;
    self.wheelStartAngle = atan2f(dy,dx);
    return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch*)touch withEvent:(UIEvent*)event
{
    CGPoint pt = [touch locationInView:self];
    float dx = pt.x  - self.container.center.x;
	float dy = pt.y  - self.container.center.y;
	float ang = atan2(dy,dx);
    float angleDifference = ang - self.wheelStartAngle;
    
    if (angleDifference < [self degreesToRadians:-180])
    {
        angleDifference += [self degreesToRadians:360];
    }
    if (angleDifference > [self degreesToRadians:180]) {
        angleDifference -= [self degreesToRadians:360];
    }
    
    /* should not go outside range */
    float totalDegrees = [self radiansToDegrees:(self.totalRotation + angleDifference)];
    if ((0 >= totalDegrees) || ((float)self.wheelRotationRange <= totalDegrees))
    {
        self.wheelStartAngle = ang;
        return YES;
    }
    
    CGFloat angleSize = 2*M_PI/NUMBER_OF_TEETH;
    NSArray *views = [_container subviews];
    for (UIView *im in views)
    {
        float teethRotationAngle = (angleDifference + _totalRotation)*_teethRotationFactor + _teethStartingAngle;
        im.transform = CGAffineTransformMakeRotation(teethRotationAngle + im.tag*angleSize );
        if (im.tag == 5)
        {
            CAShapeLayer *maskLayer = [self maskLayerFor6thPetalWithTheta:[self radiansToDegrees:teethRotationAngle]];
            im.layer.mask = maskLayer;
        }
        if (im.tag == 4)
        {
            CAShapeLayer *maskLayer = [self maskLayerFor5thPetalWithTheta:[self radiansToDegrees:teethRotationAngle]];
            im.layer.mask = maskLayer; 
        }
    }
    self.wheelStartAngle = ang;
    self.totalRotation += angleDifference;
    return YES;
}

- (void)endTrackingWithTouch:(UITouch*)touch withEvent:(UIEvent*)event
{
    int numberOfStages = [_stagesArray count];
    float anglePerStage = (float)_wheelRotationRange/(float)numberOfStages;
    int stage = (int)([self radiansToDegrees:_totalRotation]/anglePerStage);
    if ([self.delegate respondsToSelector:@selector(reachedStage:atIndex:)])
    {
        [self.delegate reachedStage:[_stagesArray objectAtIndex:stage] atIndex:stage];
    }
}

- (CAShapeLayer *)maskLayerFor6thPetalWithTheta:(float)theta
{
    float sinVal = sinf([self degreesToRadians:(60.0f-theta)]);
    float constantVal = (2*TEETH_RADIUS)/sqrtf(3.0f);
    float xTop = constantVal*sinVal;
    float xBot = xTop + TEETH_RADIUS/sqrtf(3.0f);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, xTop, 0);
    CGPathAddLineToPoint(path, NULL, 2*TEETH_RADIUS, 0);
    CGPathAddLineToPoint(path, NULL, 2*TEETH_RADIUS, TEETH_RADIUS);
    CGPathAddLineToPoint(path, NULL, xBot, TEETH_RADIUS);
    CGPathCloseSubpath(path);
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    [maskLayer setPath:path];
    CGPathRelease(path);
    return maskLayer;
}

- (CAShapeLayer *)maskLayerFor5thPetalWithTheta:(float)theta
{
    float sinVal = sinf([self degreesToRadians:(30.0-theta)]);
    float constantVal = 2*TEETH_RADIUS;
    float xTop = constantVal*sinVal;
    float xBot = xTop + TEETH_RADIUS/sqrtf(3.0);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, xTop, 0);
    CGPathAddLineToPoint(path, NULL, 2*TEETH_RADIUS, 0);
    CGPathAddLineToPoint(path, NULL, 2*TEETH_RADIUS, TEETH_RADIUS);
    CGPathAddLineToPoint(path, NULL, xBot, TEETH_RADIUS);
    CGPathCloseSubpath(path);
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    [maskLayer setPath:path];
    CGPathRelease(path);
    return maskLayer;
}
@end
