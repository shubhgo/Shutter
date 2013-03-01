//
//  common.m
//  Shutter
//
//  Created by Shubham Goel on 25/02/13.
//  Copyright (c) 2013 Shubham Goel. All rights reserved.
//

#import "Common.h"
#import "QuartzCore/QuartzCore.h"

@implementation Common
+(UIImage *)imageFromView:(UIView *)view
{
    UIGraphicsBeginImageContext(view.frame.size);
    [[view layer] renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenshot;
}

+(BOOL)saveImageToDisk:(UIImage *)image
{
    // Convert UIImage to JPEG
    NSData *imgData = UIImageJPEGRepresentation(image, 1);
    
    // Identify the home directory and file name
    NSString  *jpgPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Test.jpg"];
    
    // Write the file.  Choose YES atomically to enforce an all or none write. Use the NO flag if partially written files are okay which can occur in cases of corruption
    return [imgData writeToFile:jpgPath atomically:YES];
}
@end
