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
    NSArray *stages = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"9",@"10"];
    NSRange teethRotationRange = NSMakeRange(5, 40); // 1)in degrees 2) 0degree closes the aperture completely
    int wheelRotationRange = 360;
    CGRect shutterFrame = CGRectMake(0, 0, 200, 200);
    self.shutter = [[SGShutterView alloc] initWithFrame:shutterFrame
                                     teethRotationRange:teethRotationRange
                                     wheelRotationRange:wheelRotationRange
                                             stageArray:stages];
    self.shutter.center = CGPointMake(160, 240);
    [self.view addSubview:self.shutter];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
