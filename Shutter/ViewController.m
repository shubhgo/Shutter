//
//  ViewController.m
//  Shutter
//
//  Created by Shubham Goel on 15/02/13.
//  Copyright (c) 2013 Shubham Goel. All rights reserved.
//

#import "ViewController.h"
#import "SGShutterView.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()
@property (strong, nonatomic) SGShutterView *shutter;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    
    /* Shutter View */
    self.shutter = [[SGShutterView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    self.shutter.center = CGPointMake(160, 240);
    [self.view addSubview:self.shutter];
    
    /* add mask */
    // Create your mask layer
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, 90, 0);
    CGPathAddLineToPoint(path, NULL, 90, 90);
    CGPathAddLineToPoint(path, NULL, 0, 0);
    CGPathCloseSubpath(path);
    
    
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    [maskLayer setPath:path];
//    CGPathRelease(path);
//    self.teeth.layer.mask = maskLayer;
    self.someView.hidden = YES;
    self.teeth.hidden = YES;
//    self.someView.layer.mask = maskLayer;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)save:(id)sender
{
//    [self.shutter save];
}
@end
