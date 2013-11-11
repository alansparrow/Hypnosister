//
//  LogoView.m
//  Hypnosister
//
//  Created by Alan Sparrow on 11/11/13.
//  Copyright (c) 2013 Alan Sparrow. All rights reserved.
//

#import "LogoView.h"

@implementation LogoView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self setBackgroundColor:[UIColor clearColor]];
    }
    
    return self;
}

- (void)drawRect:(CGRect)logoView
{
    
    UIImage *image = [UIImage imageNamed:@"bnr-twitter-logo.png"];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect bounds = [self bounds];
    bounds.size.width -= 10;
    bounds.size.height -= 10;
    
    // Get the center of the bounds rectangle
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
    float radius = bounds.size.width / 2.0;
    
    // Add shadow
    CGContextSaveGState(ctx);
    CGContextAddArc(ctx, center.x, center.y, radius, 0.0, M_PI*2.0, YES);
    CGContextSetShadowWithColor(ctx, CGSizeMake(0, 1), 4, [[UIColor blackColor] CGColor]);
    // Paint the circle with its shadow
    CGContextStrokePath(ctx);
    CGContextRestoreGState(ctx);
    
    CGContextAddArc(ctx, center.x, center.y, radius, 0.0, M_PI*2.0, YES);
    CGContextClip(ctx);
    
    [image drawInRect:bounds];
    
    // Add gradient
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    // Create the colors
    float colors[8] =
    {
        0.04f, 0.10f, 0.90f, 0.5f,
        1.00f, 1.00f, 1.00f, 0.25f
    };
    
    // Start and endpoints: top center to bottom
    CGPoint startPoint = CGPointMake(center.x, 0.0);
    CGPoint endPoint = CGPointMake(center.x, bounds.size.height);
    
    // Create the gradient object
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, colors, NULL, 2);
    
    // Draw the gradient
    CGContextDrawLinearGradient(ctx, gradient, startPoint, endPoint, kCGGradientDrawsAfterEndLocation);
}

@end
