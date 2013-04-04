//
//  UFDFancySegue.m
//  Custom Transitions
//
//  Created by Storyboard Presenter on 4/3/13.
//  Copyright (c) 2013 Ulrik Damm. All rights reserved.
//

#import "UFDFancySegue.h"
#import <QuartzCore/QuartzCore.h>

@interface UFDFancySegue ()

@property (weak, nonatomic) UIImageView *imageView;

@end

@implementation UFDFancySegue

- (void)perform {
	UIGraphicsBeginImageContextWithOptions(CGSizeMake([self.sourceViewController view].frame.size.width * 2, [self.sourceViewController view].frame.size.height * 2), YES, 0);
	[[self.destinationViewController view].layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();

	UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
	self.imageView = imageView;
	[[self.sourceViewController view] addSubview:imageView];
	
	CALayer *layer = [CALayer layer];
	layer.frame = [self.sourceViewController view].bounds;
	imageView.layer.mask = layer;
	
	NSMutableArray *circleLayers = [NSMutableArray array];
	
	CGSize size = [self.sourceViewController view].bounds.size;
	
	int x = 3;
	int y = 5;
	
	CGFloat xsize = size.width / x * sqrt(2);
	CGFloat ysize = size.height / y * sqrt(2);
	
	int i, j;
	for (i = 0; i < x; i++) {
		for (j = 0; j < y; j++) {
			CAShapeLayer *circle = [CAShapeLayer layer];
			circle.frame = CGRectMake(size.width / x * i + size.width / x / 2 - xsize / 2, size.height / y * j + size.height / y / 2 - ysize / 2, xsize, ysize);
			circle.path = CGPathCreateWithEllipseInRect(circle.bounds, NULL);
			circle.transform = CATransform3DMakeScale(0.01, 0.01, 0.01);
			[layer addSublayer:circle];
			[circleLayers addObject:circle];
		}
	}

	CAAnimationGroup *group = [CAAnimationGroup animation];
	group.delegate = self;
    group.duration = 1;
    
    CABasicAnimation *transform = [CABasicAnimation animationWithKeyPath:@"transform"];
    transform.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
	
    group.animations = @[ transform ];
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
	
    [CATransaction flush];

	for (CALayer *circle in circleLayers) {
		[circle addAnimation:group forKey:@"sfsdf"];
	}
	
	double delayInSeconds = group.duration;
	dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
	dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
		if ([self isRewinding]) {
			[self.sourceViewController dismissViewControllerAnimated:NO completion:nil];
		} else {
			[self.sourceViewController presentViewController:self.destinationViewController animated:NO completion:nil];
		}
	});
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
	[self.imageView removeFromSuperview];
}

@end
