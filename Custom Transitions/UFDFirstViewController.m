//
//  UFDFirstViewController.m
//  Custom Transitions
//
//  Created by Storyboard Presenter on 4/3/13.
//  Copyright (c) 2013 Ulrik Damm. All rights reserved.
//

#import "UFDFirstViewController.h"
#import "UFDFancySegue.h"
#import "UFDSwipeSegue.h"

@interface UFDFirstViewController () <UIGestureRecognizerDelegate>

@property (strong, nonatomic) UFDSwipeSegue *segue;

@end

@implementation UFDFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
	pan.delegate = self;
	[self.view addGestureRecognizer:pan];
}

- (IBAction)backToStart:(UIStoryboardSegue *)segue {
	
}

- (UIStoryboardSegue *)segueForUnwindingToViewController:(UIViewController *)toViewController fromViewController:(UIViewController *)fromViewController identifier:(NSString *)identifier {
	UFDFancySegue *segue = [[UFDFancySegue alloc] initWithIdentifier:identifier source:fromViewController destination:toViewController];
	segue.rewinding = YES;
	return segue;
}






- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:@"segue"]) {
		self.segue = (UFDSwipeSegue *)segue;
		
	}
}

- (void)pan:(UIPanGestureRecognizer *)pan {
	if (!self.segue) {
		[self performSegueWithIdentifier:@"segue" sender:self];
	}
	
	if (pan.numberOfTouches > 0) {
		self.segue.xpos = [pan locationOfTouch:0 inView:self.view].x;
	} else {
		[self.segue done];
		self.segue = nil;
	}
}

#pragma mark - Gesture recognizer

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
	if ([touch locationInView:self.view].x > 300) {
		return YES;
	}
	
	return NO;
}

@end
