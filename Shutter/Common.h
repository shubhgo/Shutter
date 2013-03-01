//
//  common.h
//  Shutter
//
//  Created by Shubham Goel on 25/02/13.
//  Copyright (c) 2013 Shubham Goel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Common : NSObject
+(UIImage *)imageFromView:(UIView *)view;
+(BOOL)saveImageToDisk:(UIImage *)image;
@end
