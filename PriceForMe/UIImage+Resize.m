//
//  UIImage+Resize.m
//  PriceForMe
//
//  Created by SergeantSA on 5/17/15.
//  Copyright (c) 2015 PriceForMe. All rights reserved.
//

#import "UIImage+Resize.h"

@implementation UIImage (Resize)

- (UIImage *)scaledToSize:(CGSize)size
{
  CGFloat horizontalRatio = size.width / self.size.width;
  CGFloat verticalRatio = size.height / self.size.height;
  CGFloat ratio = MIN(horizontalRatio, verticalRatio);
  CGSize newSize = CGSizeMake(self.size.width * ratio,
                              self.size.height * ratio);
  UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
  [self drawInRect:
                CGRectMake(0, 0, newSize.width, newSize.height)];
  UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return newImage;
}

@end
