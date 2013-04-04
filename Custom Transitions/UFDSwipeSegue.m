//
//  UFDSwipeSegue.m
//  Custom Transitions
//
//  Created by Storyboard Presenter on 4/3/13.
//  Copyright (c) 2013 Ulrik Damm. All rights reserved.
//

#import "UFDSwipeSegue.h"

@implementation UFDSwipeSegue

- (void)perform {
	[[self.sourceViewController view] addSubview:[self.destinationViewController view]];
}

- (void)setXpos:(CGFloat)xpos {
	_xpos = xpos;
	
	[self.destinationViewController view].frame = (CGRect) { .origin = { xpos, 0 }, .size = [self.sourceViewController view].frame.size };
}

- (void)done {
	[UIView animateWithDuration:.3 animations:^{
		[self.destinationViewController view].frame = (CGRect) { .origin = { 0, 0 }, .size = [self.sourceViewController view].frame.size };
	} completion:^(BOOL finished) {
		[[self.destinationViewController view] removeFromSuperview];
		[self.sourceViewController presentViewController:self.destinationViewController animated:NO completion:nil];
	}];
}

@end
