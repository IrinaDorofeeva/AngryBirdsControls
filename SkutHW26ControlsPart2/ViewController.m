//
//  ViewController.m
//  SkutHW26ControlsPart2
//
//  Created by Mac on 5/31/16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import "ViewController.h"


typedef enum {
    IDAnimalTypeFox,
    IDAnimalTypeTiger,
    IDAnimalTypeDeer
}IDAnimalType;

typedef enum {
    scaleUp,
    scaleDown
} Scale;

@interface ViewController ()

@property (weak, nonatomic) UIImageView* imageHolder;
@property (assign, nonatomic) Scale nextScale;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // [self refreshImage];
  // ?
       /* UIImageView *imageHolder = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.testView.bounds)-50, CGRectGetMidY(self.testView.bounds)-50,50,50)];*/
        UIImage *image = [UIImage imageNamed:@"angry birds-01.png"];
      self.imageHolder.image = image;
      [self.testView addSubview:self.imageHolder];
    
        //self.imageHolder=imageHolder;*/

    
}

#pragma mark - Private Methods

-(void) refreshImage {
    
        if (self.animalsSegmentedControl.selectedSegmentIndex==IDAnimalTypeFox){
        UIImage *image = [UIImage imageNamed:@"angry birds-01.png"];
        self.imageHolder.image = image;
        [self.testView addSubview:self.imageHolder];}
    
        if (self.animalsSegmentedControl.selectedSegmentIndex==IDAnimalTypeTiger){
        UIImage *image = [UIImage imageNamed:@"angry birds-02.png"];
        self.imageHolder.image = image;
        [self.testView addSubview:self.imageHolder];}
    
        if (self.animalsSegmentedControl.selectedSegmentIndex==IDAnimalTypeDeer){
        UIImage *image = [UIImage imageNamed:@"angry birds-03.png"];
        self.imageHolder.image = image;
        [self.testView addSubview:self.imageHolder];}
    
}

- (IBAction) actionSpeedSlider:(UISlider *)sender {
    NSLog(@"%f",self.speedSlider.value);
}

- (IBAction)actionAnimalsSegmentedControl:(UISegmentedControl *)sender {
    [self refreshImage];
}
- (IBAction)actionAnimationSwitch:(UISwitch *)sender {

    if(sender==self.translationSwitch){
        [self moveView:self.imageHolder withSender:self.translationSwitch];}
    
    if(sender==self.rotationSwitch){
        [self rotateView:self.imageHolder withSender:self.rotationSwitch];
    }
    if(sender==self.scaleSwitch){
        [self scaleView:self.imageHolder withSender:self.scaleSwitch];
    }
}


#pragma mark - animation mathods

-(void) moveView: (UIImageView*) imageView withSender:(UISwitch*) sender {
    CGRect rectView = self.testView.bounds;
    CGRect rectImage =imageView.bounds;
    CGFloat x =arc4random() % (int)(CGRectGetWidth(rectView)-(CGRectGetWidth(rectImage)/1))+CGRectGetMinX(rectView)+(CGRectGetWidth(rectImage)/2);
    CGFloat y =arc4random() % (int)(CGRectGetHeight(rectView)-(CGRectGetHeight(rectImage)/1))+CGRectGetMinY(rectView)+(CGRectGetHeight(rectImage)/2);
  
    [UIView transitionWithView:
    imageView duration:(4/self.speedSlider.value)
               options:UIViewAnimationOptionCurveLinear
            animations:^{
        
                if(sender.isOn){
                    imageView.center=CGPointMake(x, y);
                }
                else{
                    imageView.center=imageView.center;
                }
        
            }
            completion:^(BOOL finished){
            if(sender.isOn){
           __weak UIImageView* v = imageView;
           [self moveView:v withSender:sender];
           }}];
}

- (void) rotateView: (UIImageView*) imageView withSender: (UISwitch*) sender{
    
    CGAffineTransform currentTransform = imageView.transform;
    [UIView animateWithDuration:(0.33/self.speedSlider.value)
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         
                         if(sender.isOn){
                             imageView.transform = CGAffineTransformRotate(currentTransform, +3.14);
                         }
                         else{
                              imageView.transform = CGAffineTransformRotate(currentTransform, 0);
                         }
                    }
                     completion:^(BOOL finished) {
                         NSLog(@"Moving was ended to point %@ and %d", NSStringFromCGPoint(imageView.center), sender.isOn);
                         if (sender.isOn) {
                             __weak UIImageView* v = imageView;
                            [self rotateView:v withSender:sender];
                             NSLog(@"Moving was ended to point %@", NSStringFromCGPoint(imageView.center));

                         }
                     }];
}

- (void) scaleView: (UIImageView*) imageView withSender: (UISwitch*) sender{
    
    
    [UIView animateWithDuration:(0.5/self.speedSlider.value)
                          delay:0.5
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         CGFloat newScale;
                         if (self.nextScale == scaleUp) {
                             newScale = 2;
                             self.nextScale = scaleDown;
                         }
                         else {
                             newScale = 0.5;
                             self.nextScale = scaleUp;
                         }
                         CGAffineTransform currentTransform = imageView.transform;
                         
                         if(sender.isOn){
                             imageView.transform = CGAffineTransformScale(currentTransform, newScale, newScale);
                         }
                         else{
                             imageView.transform = CGAffineTransformScale(currentTransform, 1, 1);
                         }
                         
                     }
                     completion:^(BOOL finished) {
                         if (sender.isOn) {
                              __weak UIImageView* v = imageView;
                             [self scaleView:v withSender:sender];
                         }
                     }];
}


- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
    
    
@end






/*
 Ученик.
 
 1. Расположите тестируюмую вьюху на верхней половине экрана
 2. На нижней половине создайте 3 свича: Rotation, Scale, Translation. По умолчанию все 3 выключены
 3. Также создайте сладер скорость, со значениями от 0.5 до 2, стартовое значение 1
 4. Создайте соответствующие проперти для свитчей и слайдера, а также методы для события valueChanged
 
 Студент.
 
 5. Добавьте сегментед контрол с тремя разными сегментами
 6. Они должны соответствовать трем разным картинкам, которые вы должны добавить
 7. Когда переключаю сегменты, то картинка должна меняться на соответствующую
 
 Мастер.
 
 8. Как только мы включаем один из свичей, наша вьюха должна начать соответствующую анимацию
 (либо поворот, либо скеил, либо перенос). Используйте свойство transform из урока об анимациях
 9. Так же следует помнить, что если вы переключили свич, но какойто другой включен одновременно с ним, то вы должны делать уже двойную анимацию. Например и увеличение и поворот одновременно (из урока про анимации)
 10. Анимации должны быть бесконечно повторяющимися, единственное что их может остановить, так это когда все три свича выключены
 
 Супермен.
 
 11. Добавляем использование слайдера. Слайдер регулирует скорость. То есть когда значение на 0.5, то скорость анимаций должна быть в два раза медленнее, а если на 2, то в два раза быстрее обычной.
 12. Попробуйте сделать так, чтобы когда двигался слайдер, то анимация обновлялась без прерывания, а скорость изменялась в соответствующую сторону.
 
 */
