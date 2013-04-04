//
//  UFDPopSegue.m
//  Custom Transitions
//
//  Created by Storyboard Presenter on 4/3/13.
//  Copyright (c) 2013 Ulrik Damm. All rights reserved.
//

#import "UFDPopSegue.h"
#import <QuartzCore/QuartzCore.h>

@implementation UFDPopSegue

- (void)perform {
	UIGraphicsBeginImageContextWithOptions([self.sourceViewController view].frame.size, YES, 0);
	[[self.destinationViewController view].layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
	imageView.frame = [self.sourceViewController view].bounds;
	imageView.transform = CGAffineTransformMakeScale(0.01, 0.01);
	[[self.sourceViewController view] addSubview:imageView];
	
	[UIView animateWithDuration:.3 animations:^{
		imageView.transform = CGAffineTransformMakeScale(1.1, 1.1);
	} completion:^(BOOL finished) {
		[UIView animateWithDuration:.3 animations:^{
			imageView.transform = CGAffineTransformIdentity;
		} completion:^(BOOL finished) {
			[imageView removeFromSuperview];
			[self.sourceViewController presentViewController:self.destinationViewController animated:NO completion:nil];
		}];
	}];
}

@end
