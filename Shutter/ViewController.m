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
    CALayer* maskLayer = [CALayer layer];
    maskLayer.frame = CGRectMake(10,50,90,89);
    maskLayer.contents = (__bridge id)[[UIImage imageNamed:@"teeth.png"] CGImage];
    self.teeth.layer.mask = maskLayer;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)save:(id)sender
{
    [self.shutter save];
}
@end
