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
<SGShutterViewDelegate>
@property (strong, nonatomic) SGShutterView *shutter;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    /* Shutter View */
    NSArray *stages = @[@"a1",@"b2",@"c3",@"d4",@"e5",@"f6",@"g7",@"h9",@"i10"];
    NSRange teethRotationRange = NSMakeRange(5, 40); // 1)in degrees 2) 0degree closes the aperture completely
    int wheelRotationRange = 360;
    CGRect shutterFrame = CGRectMake(0, 0, 320, 568);
    self.shutter = [[SGShutterView alloc] initWithFrame:shutterFrame
                                     teethRotationRange:teethRotationRange
                                     wheelRotationRange:wheelRotationRange
                                             stageArray:stages];
    self.shutter.center = CGPointMake(160, 284);
    self.shutter.delegate = self;
    [self.view addSubview:self.shutter];
    [self.shutter addMask];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reachedStage:(NSString *)stageName atIndex:(NSInteger)stageIndex
{
    NSLog(@"reachedStage: %@",stageName);
}
@end
