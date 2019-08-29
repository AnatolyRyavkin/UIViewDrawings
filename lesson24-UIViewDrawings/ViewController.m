//
//  ViewController.m
//  lesson24-UIViewDrawings
//
//  Created by Anatoly Ryavkin on 18/04/2019.
//  Copyright © 2019 AnatolyRyavkin. All rights reserved.


#import "ViewController.h"

@interface ViewController ()
//@property IBOutlet Drawing* v1;
@property (strong) ViewController*VC;
@property (strong) Drawing* v1;
@property (strong) UIView*viewBase;
@property UITapGestureRecognizer*tap1;
@property UITapGestureRecognizer*tap2;
@property UITapGestureRecognizer*tap3;
@property UISwipeGestureRecognizer*swipeRight;
@property UISwipeGestureRecognizer*swipeLeft;
@property (strong)UIPinchGestureRecognizer*pinch;
@property UIRotationGestureRecognizer*rotation;
@property (strong) UIPanGestureRecognizer*pan;
@property UIViewPropertyAnimator*animate;
@property UIViewPropertyAnimator* animateTap2;
@property UIViewPropertyAnimator*animateRotat;
@property double angle;
@property CGFloat scale;
@property CGAffineTransform transScale;
@property CGAffineTransform transRotat;
@property int flagR;
@property int flagL;
@property int count;
@property int flagHome;
@property UISwipeGestureRecognizer* senderSwipe;
-(void)handleTap1:(UITapGestureRecognizer *)sender;
-(void)handleTap2:(UITapGestureRecognizer *)sender;
-(void)handleTap3:(UITapGestureRecognizer *)sender;
-(void)handleSwipeRight:(UISwipeGestureRecognizer*)sender;
-(void)handleSwipeLeft:(UISwipeGestureRecognizer*)sender;
-(void)handlePan:(UIPanGestureRecognizer*)sender;
-(void)handleRotation:(UIRotationGestureRecognizer*)sender;
-(double)returnRandomCountColor;
-(UIColor*)randomColor;
@end


@implementation ViewController

-(double)returnRandomCountColor{
    double result=((double)((arc4random()*10000)%1000))/1000;
    NSLog(@"result= %f",result);
    return result;
}
-(UIColor*)randomColor{
    return [UIColor colorWithRed:[self returnRandomCountColor] green:[self returnRandomCountColor] blue:[self returnRandomCountColor] alpha:1];
}

#pragma mark - rotation

-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [self.v1 setNeedsDisplay];
}

#pragma mark - Tap1

- (void)handleTap1:(UITapGestureRecognizer *)sender
{
        //NSLog(@"begin Tap1");
    if(self.animateTap2.userInteractionEnabled==YES){
        [self.animateTap2 stopAnimation:NO];
        [self.animateTap2 finishAnimationAtPosition:UIViewAnimatingPositionCurrent];
        self.animateTap2=nil;
        CGAffineTransform transform=self.viewBase.layer.presentationLayer.affineTransform;
        self.angle=atan(-transform.c/transform.d);
        self.transRotat=CGAffineTransformMakeRotation(self.angle);
        self.scale=transform.d/cos(self.angle);
    }
    [self.animate stopAnimation:NO]; // !!!!!!!!!!!!!!!!!! если убрать то не работает!!!!!!!  вместо  [self.v1.layer removeAllAnimations];
    [self.animate finishAnimationAtPosition:  UIViewAnimatingPositionCurrent];
    self.animate=nil;
        //CALayer*layer=self.v1.layer.presentationLayer;
        //self.v1.layer.position=layer.position;    //ставит только в позицию!!!!

    self.animate=[[UIViewPropertyAnimator alloc]initWithDuration:5 curve:UIViewAnimationCurveLinear animations:^{
        self.viewBase.layer.position=[sender locationInView:self.view];
        //self.viewBase.backgroundColor=[[UIColor yellowColor]colorWithAlphaComponent:0];
    }];

    [self.animate startAnimation];
    if (sender.state == UIGestureRecognizerStateEnded)
        {
        //self.viewBase.backgroundColor=  [[UIColor blueColor]colorWithAlphaComponent:0];
        }
}

#pragma mark - Tap2
- (void)handleTap2:(UITapGestureRecognizer *)sender
{
        //NSLog(@"begin Tap2");
    self.flagHome=0;
    [self.animate stopAnimation:NO];
    [self.animate finishAnimationAtPosition:  UIViewAnimatingPositionCurrent];
    self.count=0;
    [self.animateRotat stopAnimation:NO];
    [self.animateRotat finishAnimationAtPosition:  UIViewAnimatingPositionCurrent];
    self.animateRotat=nil;

    double angle=((double)((int)(self.angle*10000) % (int)(M_PI*10000)))/10000;
    if(angle==0){
        self.animateTap2=[[UIViewPropertyAnimator alloc]initWithDuration:3 curve:UIViewAnimationCurveLinear animations:^{
            self.viewBase.center=CGPointMake(CGRectGetMidX(self.view.bounds),CGRectGetMidY(self.view.bounds));
            //self.viewBase.backgroundColor=  [[UIColor grayColor]colorWithAlphaComponent:0];
            self.viewBase.transform=CGAffineTransformMake(1, 0, 0, 1, 0, 0);
        }];
#pragma mark BLOK
        __weak ViewController* selfTemp=self;
        [self.animateTap2 addCompletion:^(UIViewAnimatingPosition finalPosition) {
            if(finalPosition==UIViewAnimatingPositionEnd){
                selfTemp.scale=1;
                selfTemp.transRotat=CGAffineTransformMakeRotation(0);
                selfTemp.transScale=CGAffineTransformMakeScale(1, 1);
                selfTemp.angle=0;
            }
        }];
        [self.animateTap2 startAnimation];
    }
    else{

        self.animateTap2=[[UIViewPropertyAnimator alloc]initWithDuration:3 curve:UIViewAnimationCurveLinear animations:^{
            self.viewBase.center=CGPointMake(350, 450);
            //self.viewBase.backgroundColor=  [[UIColor redColor]colorWithAlphaComponent:0];
            self.viewBase.transform=CGAffineTransformMake(1, 0, 0, 1, 0, 0);// CGAffineTransformMakeRotation(0);
        }];
        __weak ViewController* selfTemp=self;
        [self.animateTap2 addCompletion:^(UIViewAnimatingPosition finalPosition) {
            if(finalPosition==UIViewAnimatingPositionEnd){
                selfTemp.scale=1;
                selfTemp.transRotat=CGAffineTransformMakeRotation(0);
                selfTemp.transScale=CGAffineTransformMakeScale(1, 1);
                selfTemp.angle=0;
            }
            if(finalPosition==UIViewAnimatingPositionCurrent){
                CGAffineTransform transform=selfTemp.viewBase.layer.presentationLayer.affineTransform;
                    //NSLog(@"transform=%@",NSStringFromCGAffineTransform(transform));
                    //NSLog(@"!!!!!!!   alph=acos(a/scaleX)=%f",acos(transform.a/self.scale)); dont!!!
                    //NSLog(@"!!!!!!!   alph=asin(b)=%f",asin(transform.b));  dont!!!
                    //NSLog(@"!!!!!!!   alph=atan(-transform.c/transform.d)=%f",atan(-transform.c/transform.d));  GOOD!!!!!!!!!!!!!!!
                selfTemp.angle=atan(-transform.c/transform.d);
                selfTemp.transRotat=CGAffineTransformMakeRotation(selfTemp.angle);
                selfTemp.scale=transform.d/cos(selfTemp.angle);
                selfTemp.transScale=CGAffineTransformMakeScale(selfTemp.scale, selfTemp.scale);
            }
        }];
        [self.animateTap2 startAnimation];
    }
    self.flagR=1;
    self.flagL=1;
    self.count=0;
}

#pragma mark - Tap3
-(void)handleTap3:(UITapGestureRecognizer *)sender
{
        //NSLog(@"1-self.animateTap2.userInteractionEnabled= %i",self.animateTap2.userInteractionEnabled);
        //NSLog(@"begin Tap3");
    [self.viewBase.layer removeAllAnimations];
    [self.animate stopAnimation:NO];
    [self.animate finishAnimationAtPosition:  UIViewAnimatingPositionCurrent];
    self.animate=nil;
    [self.animateTap2 stopAnimation:NO];
    [self.animateTap2 finishAnimationAtPosition:  UIViewAnimatingPositionCurrent];
    self.animateTap2=nil;
    [self.animateRotat stopAnimation:NO];
    [self.animateRotat finishAnimationAtPosition:  UIViewAnimatingPositionCurrent];
    self.animateRotat=nil;
    self.count=0;
    self.flagHome=1;
    CGAffineTransform transform=self.viewBase.layer.presentationLayer.affineTransform;
    self.angle=atan(-transform.c/transform.d);
    self.transRotat=CGAffineTransformMakeRotation(self.angle);
    self.scale=transform.d/cos(self.angle);
    self.transScale=CGAffineTransformMakeScale(self.scale, self.scale);
        //[self.animateTap2 finishAnimationAtPosition:  UIViewAnimatingPositionCurrent]; почему то не оставляет в текущей позиции!!!
        //приходиться ставить так ->
        //CALayer*layer=self.v1.layer.presentationLayer;
        //self.v1.layer.position=layer.position;


    self.flagR=1;
    self.flagL=1;
}

#pragma mark - SwipeRight

-(void)handleSwipeRight:(UISwipeGestureRecognizer*)sender{
        //NSLog(@"begin swipe right+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
    self.flagHome=1;
    if(self.animateTap2.userInteractionEnabled==YES){
        [self.animateTap2 stopAnimation:NO];
        [self.animateTap2 finishAnimationAtPosition:UIViewAnimatingPositionCurrent];
        self.animateTap2=nil;
        CGAffineTransform transform=self.viewBase.layer.presentationLayer.affineTransform;
        self.angle=atan(-transform.c/transform.d);
        self.transRotat=CGAffineTransformMakeRotation(self.angle);
        self.scale=transform.d/cos(self.angle);
        [self.viewBase.layer removeAllAnimations];
    }
    if(!(sender==nil))
        self.count++;
    sender=nil;
    self.animateRotat=nil;
    self.flagR=0;
    self.flagL=1;
    self.angle=self.angle+(M_PI)/60;
    self.transRotat=CGAffineTransformMakeRotation(self.angle);
    self.animateRotat=[[UIViewPropertyAnimator alloc]initWithDuration:0.1 curve:UIViewAnimationCurveLinear animations:^{
        self.viewBase.transform=CGAffineTransformConcat(self.transRotat, self.transScale);
    }];

    [self.animateRotat startAnimation];
    double delayInSeconds = 0.1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        if (self.flagR==0){
            [self handleSwipeRight:nil];
        }
    }
                   );
}

#pragma mark - SwipeLeft

-(void)handleSwipeLeft:(UISwipeGestureRecognizer*)sender{
        //NSLog(@"begin swipe left----------------------------------------------------------------------------------------------------------");
    self.flagHome=1;
    if(self.animateTap2.userInteractionEnabled==YES){
        [self.animateTap2 stopAnimation:NO];
        [self.animateTap2 finishAnimationAtPosition:UIViewAnimatingPositionCurrent];
        self.animateTap2=nil;
        CGAffineTransform transform=self.viewBase.layer.presentationLayer.affineTransform;
        self.angle=atan(-transform.c/transform.d);
        self.transRotat=CGAffineTransformMakeRotation(self.angle);
        self.scale=transform.d/cos(self.angle);
        [self.viewBase.layer removeAllAnimations];
    }
    if(!(sender==nil))
        self.count++;
    sender=nil;
    self.animateRotat=nil;
    self.flagR=1;
    self.flagL=0;
    self.angle=self.angle-(M_PI)/60;
    self.transRotat=CGAffineTransformMakeRotation(self.angle);

    self.animateRotat=[[UIViewPropertyAnimator alloc]initWithDuration:0.1 curve:UIViewAnimationCurveLinear animations:^{
        self.viewBase.transform=CGAffineTransformConcat(self.transRotat, self.transScale);
    }];

    [self.animateRotat startAnimation];
    double delayInSeconds = 0.1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        if (self.flagL==0){
            [self handleSwipeLeft:nil];
        }
    });
}

#pragma mark - Pinch
    //копия измененная->
/* останавливает в паузу вращение скайлит и запускает далее вращение
 но с точки скайла и роташна

 -(void)handlePinch:(UIPinchGestureRecognizer*)sender{

 NSLog(@" pinch-----------------------------------------------------------------------------------------------");
 int static pinchCount=0;
 int static rotationActive=0;
 if(pinchCount==0) {
 if (self.flagR==0) rotationActive=1;
 if (self.flagL==0) rotationActive=2;
 }
 if(sender.state==UIGestureRecognizerStateBegan){
 NSLog(@"begin pinch +++++++++++++++++++++++++++++++++++++++++++++++++++++=");
 pinchCount++;
 }
 if(self.animateTap2.userInteractionEnabled==YES){
 [self.animateTap2 stopAnimation:NO];
 [self.animateTap2 finishAnimationAtPosition:  UIViewAnimatingPositionCurrent];
 self.animateTap2=nil;
 }
 if(self.animateRotat.userInteractionEnabled==YES)
 [self.animateRotat pauseAnimation];

 //NSLog(@"sender  scale= %f",sender.scale);

 self.transScale=CGAffineTransformMakeScale(self.scale,self.scale);
 CGAffineTransform trans=CGAffineTransformScale(self.transScale, sender.scale, sender.scale);
 //[UIView animateWithDuration:0.3 animations:^{
 self.v1.transform=CGAffineTransformConcat(trans, self.transRotat);
 //}];
 self.flagR=1;
 self.flagL=1;

 if (sender.state == UIGestureRecognizerStateEnded || sender.state == UIGestureRecognizerStateFailed || sender.state==UIGestureRecognizerStateCancelled)
 {
 NSLog(@"END pinch");
 pinchCount=0;
 self.flagR=0;
 self.flagL=0;
 self.v1.backgroundColor=  [UIColor greenColor];
 self.scale=sender.scale*self.scale;
 self.transScale=CGAffineTransformMakeScale(self.scale, self.scale);
 [self.animateRotat startAnimation];
 int count=self.count;
 for(int i = 0 ; i<count; i++){
 if(rotationActive==1)
 [self handleSwipeRight:nil];
 else if(rotationActive==2)
 [self handleSwipeLeft:nil];
 }
 rotationActive=0;
 }
 }
 */

-(void)handlePinch:(UIPinchGestureRecognizer*)sender{
    if(self.animateTap2.userInteractionEnabled==YES){
        [self.animateTap2 stopAnimation:NO];
        [self.animateTap2 finishAnimationAtPosition:  UIViewAnimatingPositionCurrent];
        self.animateTap2=nil;
    }
    if(self.animateRotat.userInteractionEnabled==YES){
        [self.animateRotat stopAnimation:NO];
        [self.animateRotat finishAnimationAtPosition:  UIViewAnimatingPositionCurrent];
        self.animateRotat=nil;
        self.flagR=1;
        self.flagL=1;
    }


    CGAffineTransform scale=CGAffineTransformMakeScale(self.scale,self.scale);
    CGAffineTransform trans=CGAffineTransformScale(scale, sender.scale, sender.scale);
    self.viewBase.transform=CGAffineTransformConcat(trans, self.transRotat);
    self.transScale=trans;
    if (sender.state == UIGestureRecognizerStateEnded || sender.state == UIGestureRecognizerStateFailed || sender.state==UIGestureRecognizerStateCancelled)
        {
            //NSLog(@"END pinch");
        //self.viewBase.backgroundColor=  [[UIColor greenColor]colorWithAlphaComponent:0];
        self.scale=self.scale*sender.scale;
        self.transScale=CGAffineTransformMakeScale(self.scale,self.scale);

        }
}
#pragma mark - Pan

-(void)handlePan:(UIPanGestureRecognizer *)sender{
    CGPoint senderPoint=[sender locationInView:self.view];
    CGRect v1Rect=self.viewBase.layer.presentationLayer.frame;
    static BOOL hitPan=NO;

    if(sender.state==UIGestureRecognizerStateBegan && CGRectContainsPoint(v1Rect, senderPoint)) {
        hitPan=YES;
    }
    else if(sender.state==UIGestureRecognizerStateBegan && !CGRectContainsPoint(v1Rect, senderPoint)){
        hitPan=NO;
    }
    if(hitPan==YES)
        {
        [self.animate stopAnimation:NO];
        [self.animate finishAnimationAtPosition:  UIViewAnimatingPositionCurrent];
        self.animate=nil;

        [self.animateTap2 stopAnimation:NO];
        [self.animateTap2 finishAnimationAtPosition:  UIViewAnimatingPositionCurrent];
        self.animateTap2=nil;

        [UIView animateWithDuration:0.1 animations:^{
            self.viewBase.layer.position=senderPoint;
        }];
        }

    if(sender.state==UIGestureRecognizerStateEnded || sender.state==UIGestureRecognizerStateCancelled || sender.state==UIGestureRecognizerStateFailed) {
        hitPan=NO;
    }
}

#pragma mark - Rotation

-(void)handleRotation:(UIRotationGestureRecognizer*)sender{
    if(sender.state==UIGestureRecognizerStateBegan){
        [self.animateTap2 stopAnimation:NO];
        [self.animateTap2 finishAnimationAtPosition:UIViewAnimatingPositionCurrent];
        self.animateTap2=nil;
    }

    CGAffineTransform rot=CGAffineTransformMakeRotation(self.angle);
    CGAffineTransform trans=CGAffineTransformRotate(rot, sender.rotation);
    self.viewBase.transform=CGAffineTransformConcat(trans, self.transScale);
    self.transRotat=trans;
    if(sender.state==UIGestureRecognizerStateEnded || sender.state==UIGestureRecognizerStateCancelled || sender.state==UIGestureRecognizerStateFailed) {
        self.angle=self.angle+sender.rotation;
        self.transRotat=CGAffineTransformMakeRotation(self.angle);
    }
}

    // отдельный роташн если без совместного скайла
/*-(void)handleRotation:(UIRotationGestureRecognizer*)sender{
 NSLog(@" rotation :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::");
 //NSLog(@"angle=%f",self.angle);

 if(sender.state==UIGestureRecognizerStateBegan){
 NSLog(@"begin rotation @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
 [self.animateRotat stopAnimation:NO];
 [self.animateRotat finishAnimationAtPosition:  UIViewAnimatingPositionCurrent];
 self.animateRotat=nil;

 [self.animateTap2 stopAnimation:NO];
 [self.animateTap2 finishAnimationAtPosition:UIViewAnimatingPositionCurrent];
 self.animateTap2=nil;

 [self.view.layer removeAllAnimations];

 CGAffineTransform transformLayer=self.v1.layer.presentationLayer.affineTransform;
 self.angle=atan(-transformLayer.c/transformLayer.d);
 // NSLog(@"begin angle=%f",self.angle);
 self.transRotat=CGAffineTransformMakeRotation(self.angle);
 //self.v1.transform=CGAffineTransformConcat(self.transScale, self.transRotat);
 }

 CGAffineTransform transformLayer=self.v1.layer.presentationLayer.affineTransform;
 CGFloat angle=atan(-transformLayer.c/transformLayer.d);

 self.transRotat=CGAffineTransformMakeRotation(self.angle);
 //NSLog(@"curent layyer angle=%f",angle);

 CGAffineTransform rot = CGAffineTransformRotate(self.transRotat, sender.rotation);

 CGAffineTransform transform = CGAffineTransformConcat(self.transScale, rot);

 //[UIView animateWithDuration:0.1 animations:^{
 self.v1.transform=transform;
 //}];



 if(sender.state==UIGestureRecognizerStateEnded){//} || sender.state==UIGestureRecognizerStateCancelled){
 NSLog(@"end rotation");
 [self.animateRotat stopAnimation:NO];
 [self.animateRotat finishAnimationAtPosition:  UIViewAnimatingPositionCurrent];
 self.animateRotat=nil;
 CGAffineTransform transformLayer=self.v1.layer.presentationLayer.affineTransform;
 self.angle=atan(-transformLayer.c/transformLayer.d);
 //NSLog(@"ended angle=%f",self.angle);
 self.transRotat=CGAffineTransformMakeRotation(self.angle);
 self.v1.transform=CGAffineTransformConcat(self.transScale, self.transRotat);
 }
 }
 */

#pragma mark - UIGestureRecogniserDelegat

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    NSLog(@"1-name=%@",gestureRecognizer.name);
    NSLog(@"2-name=%@",otherGestureRecognizer.name);
    CGPoint senderPoint=[gestureRecognizer locationInView:self.view];
    CGRect v1Rect=self.viewBase.layer.presentationLayer.frame;
    if(
       ( CGRectContainsPoint(v1Rect, senderPoint) && [gestureRecognizer isMemberOfClass:[UIPanGestureRecognizer class]]) &&
       [otherGestureRecognizer isMemberOfClass:[UISwipeGestureRecognizer class]]
       ){

        /* тоже самое условие))))
         (    ((CGRectContainsPoint(v1Rect, senderPoint) && [gestureRecognizer isMemberOfClass:[UIPanGestureRecognizer class]]) ||
         (!(CGRectContainsPoint(v1Rect, senderPoint)) && [gestureRecognizer isMemberOfClass:[UISwipeGestureRecognizer class]])) &&
         (![gestureRecognizer isMemberOfClass:[UIPinchGestureRecognizer class]])&&(![otherGestureRecognizer isMemberOfClass:[UIPinchGestureRecognizer class]]) &&
         (![gestureRecognizer isMemberOfClass:[UIRotationGestureRecognizer class]])&&(![otherGestureRecognizer isMemberOfClass:[UIRotationGestureRecognizer class]])
         )}*/
        return YES; // нужно выполнить только первое
    }
    else{
        return NO; //выполнить как попало
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    NSLog(@"12-name=%@",gestureRecognizer.name);
    NSLog(@"22-name=%@",otherGestureRecognizer.name);
    CGPoint senderPoint=[otherGestureRecognizer locationInView:self.view];
    CGRect v1Rect=self.viewBase.layer.presentationLayer.frame;
    if (
        ([gestureRecognizer isMemberOfClass:[UIPanGestureRecognizer class]]) &&
        (!(CGRectContainsPoint(v1Rect, senderPoint)) && [otherGestureRecognizer isMemberOfClass:[UISwipeGestureRecognizer class]])//||
        ){
        /* тоже самое:
         ((CGRectContainsPoint(v1Rect, senderPoint) && [otherGestureRecognizer isMemberOfClass:[UIPanGestureRecognizer class]]) ||
         (!(CGRectContainsPoint(v1Rect, senderPoint)) && [otherGestureRecognizer isMemberOfClass:[UISwipeGestureRecognizer class]]))&&
         (![gestureRecognizer isMemberOfClass:[UIPinchGestureRecognizer class]])&&(![otherGestureRecognizer isMemberOfClass:[UIPinchGestureRecognizer class]])&&
         (![gestureRecognizer isMemberOfClass:[UIRotationGestureRecognizer class]])&&(![otherGestureRecognizer isMemberOfClass:[UIRotationGestureRecognizer class]])
         ){*/
        return YES; // нужно выполнить только 2
    }
    else{
    }
    return NO;

}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
        //NSLog(@"13-name=%@",gestureRecognizer.name);
        //NSLog(@"23-name=%@",otherGestureRecognizer.name);
    if(([gestureRecognizer isMemberOfClass:[UIRotationGestureRecognizer class]] && [otherGestureRecognizer isMemberOfClass:[UIPinchGestureRecognizer class]]) ||
       ([gestureRecognizer isMemberOfClass:[UIPinchGestureRecognizer class]] && [otherGestureRecognizer isMemberOfClass:[UIRotationGestureRecognizer class]]))
        return YES;
    else return NO;
}

#pragma mark - didLoad

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor=[UIColor redColor];
    self.flagHome=0;
    self.viewBase=[[UIView alloc] initWithFrame: CGRectMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame), 300, 300)];
    self.viewBase.backgroundColor=[UIColor redColor];
    [self.view addSubview:self.viewBase];
    self.v1=[[Drawing alloc]initWithFrame:self.viewBase.bounds];
    self.v1.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0];
    [self.viewBase addSubview:self.v1];
    self.v1.autoresizingMask = UIViewAutoresizingNone;
    self.scale=1;
    self.count=0;
    self.transScale=CGAffineTransformMakeScale(1, 1);
    self.transRotat=CGAffineTransformMakeRotation(0);
    self.tap1=[[UITapGestureRecognizer alloc]initWithTarget:self action: @selector(handleTap1:)];
    self.tap1.name=@"tap1";
    self.tap2=[[UITapGestureRecognizer alloc]initWithTarget:self action: @selector(handleTap2:)];
    self.tap2.numberOfTapsRequired=2;
    self.tap1.name=@"tap2";
    self.tap3=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap3:)];
    self.tap3.numberOfTapsRequired=3;
    self.tap1.name=@"tap3";
    self.swipeRight=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeRight:)];
    self.swipeRight.direction=UISwipeGestureRecognizerDirectionRight;
    self.swipeLeft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeLeft:)];
    self.swipeLeft.direction=UISwipeGestureRecognizerDirectionLeft;
    self.pinch=[[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(handlePinch:)];
    self.pan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
    self.rotation=[[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(handleRotation:)];
    self.rotation.name=@"rotation";
    self.pan.delegate=self;
    self.pan.name=@"pan";
    self.pinch.name=@"pinch";
    self.pinch.delegate=self;
    self.swipeRight.name=@"swipeRight";
    self.swipeLeft.name=@"swipeLeft";
    [self.view addGestureRecognizer:self.rotation];
    [self.view addGestureRecognizer:self.pan];
    [self.view addGestureRecognizer:self.pinch];
    [self.view addGestureRecognizer:self.swipeRight];
    [self.view addGestureRecognizer:self.swipeLeft];
    [self.view addGestureRecognizer:self.tap3];
    [self.view addGestureRecognizer:self.tap1];
    [self.view addGestureRecognizer:self.tap2];
    [self.tap1 requireGestureRecognizerToFail:self.tap2];
    [self.tap2 requireGestureRecognizerToFail:self.tap3];
}
@end
