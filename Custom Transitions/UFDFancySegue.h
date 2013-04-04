//
//  UFDFancySegue.h
//  Custom Transitions
//
//  Created by Storyboard Presenter on 4/3/13.
//  Copyright (c) 2013 Ulrik Damm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UFDFancySegue : UIStoryboardSegue

@property (assign, nonatomic, getter = isRewinding) BOOL rewinding;

@end
