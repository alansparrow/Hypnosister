//
//  HypnosisView.m
//  Hypnosister
//
//  Created by Alan Sparrow on 11/9/13.
//  Copyright (c) 2013 Alan Sparrow. All rights reserved.
//

#import "HypnosisView.h"

@implementation HypnosisView
@synthesize  circleColor;
- (void)drawRect:(CGRect)dirtyRect
{
    CGContextRef  ctx = UIGraphicsGetCurrentContext();
    CGRect bounds = [self bounds];
    
    // Figure out the center of the bounds rectangle
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
    
    // The radius of the circle should be nearly as big as the view
//    float maxRadius = hypot(bounds.size.width, bounds.size.height) / 4.0;
    float maxRadius = hypot(bounds.size.width, bounds.size.height) / 2.0;
    
    // The thickness of the line should be 10 points wide
    CGContextSetLineWidth(ctx, 10);
    
    [[self circleColor] setStroke];
    
    // The color of the line should be gray (red/green/blue = 0.6, alpha = 1.0);
//    CGContextSetRGBStrokeColor(ctx, 0.6, 0.6, 0.6, 1.0);
//    [[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1] setStroke];
//    [[UIColor lightGrayColor] setStroke];
    
    // Add a shape to the context - this does not draw the shape
//    CGContextAddArc(ctx, center.x, center.y, maxRadius, 0.0, M_PI * 2.0, YES);
    
    // Perform a drawing instruction; draw current shape with current state
//    CGContextStrokePath(ctx);
//    CGContextFillPath(ctx);
    // Draw concentric circles from the outside in
    for (float currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20)
    {
        // Add a path to the context
        CGContextAddArc(ctx, center.x, center.y, currentRadius, 0.0, M_PI * 2.0, YES);
        
        // Perform drawing instruction; removes path
        CGContextStrokePath(ctx);
        
        
        [[self getRandomColor] setStroke];
    }
    
    // Create a string
    NSString *text = @"You are getting sleepy.";
    
    // Get a font to draw it in
    UIFont *font = [UIFont boldSystemFontOfSize:28];
    
    CGRect textRect;
    
    // How big is this string when drawn in this font?
    textRect.size = [text sizeWithFont:font];
    
    // Let's put that string in the center of the view
    textRect.origin.x = center.x - textRect.size.width / 2.0;
    textRect.origin.y = center.y - textRect.size.height / 2.0;
    
    // Set the fill color of the current context to black
    [[UIColor blackColor] setFill];
    
    // The shadow will move 4 points to the right and 3 points down from the text
    CGSize offset = CGSizeMake(4, 3);
    
    // The shadow will be dark gray in color
    CGColorRef color = [[UIColor grayColor] CGColor];
    
    // Set the shadow of the context with these parameters,
    // all subsequent drawing will be shadowed
    CGContextSetShadowWithColor(ctx, offset, 2.0, color);
    // Draw the string
    [text drawInRect:textRect withFont:font];
    
    
    // Save the context state
    CGContextSaveGState(ctx);
    
    // Add green crosshair in the middle
    CGContextSetLineWidth(ctx, 5);
    [[UIColor greenColor] setStroke];
    offset = CGSizeMake(0, 0);
    CGContextSetShadowWithColor(ctx, offset, 0.0, [[UIColor greenColor] CGColor]);
    CGContextMoveToPoint(ctx, center.x, center.y - 20);
    CGContextAddLineToPoint(ctx, center.x, center.y + 20);
    CGContextStrokePath(ctx);
    
    CGContextMoveToPoint(ctx, center.x - 20, center.y);
    CGContextAddLineToPoint(ctx, center.x + 20, center.y);
    CGContextStrokePath(ctx);
    
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // All HypnosisViews start with a clear background color
        [self setBackgroundColor:[UIColor clearColor]];
        [self setCircleColor:[UIColor lightGrayColor]];
    }
    return self;
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake) {
        NSLog(@"Device started shaking!");
        [self setCircleColor:[self getRandomColor]];
    }
}

// Override property's synthesis
- (void)setCircleColor:(UIColor *) clr
{
    circleColor = clr;
    [self setNeedsDisplay];
}

- (UIColor *) getRandomColor
{
    // Set random color
    CGFloat hue = ( arc4random() % 256 / 256.0 ); // 0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    
    return color;
}
@end
