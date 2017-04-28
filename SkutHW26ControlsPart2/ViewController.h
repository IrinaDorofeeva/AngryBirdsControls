//
//  ViewController.h
//  SkutHW26ControlsPart2
//
//  Created by Mac on 5/31/16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISwitch *rotationSwitch;

@property (weak, nonatomic) IBOutlet UISwitch *scaleSwitch;

@property (weak, nonatomic) IBOutlet UISwitch *translationSwitch;
@property (weak, nonatomic) IBOutlet UISlider *speedSlider;

- (IBAction)actionSpeedSlider:(UISlider *)sender;

@property (weak, nonatomic) IBOutlet UISegmentedControl *animalsSegmentedControl;

@property (weak, nonatomic) IBOutlet UIView *testView;
- (IBAction)actionAnimalsSegmentedControl:(UISegmentedControl *)sender;

- (IBAction)actionAnimationSwitch:(UISwitch *)sender;

@end

