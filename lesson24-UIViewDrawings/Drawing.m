//
//  Draving.m
//  lesson24-UIViewDrawings
//
//  Created by Anatoly Ryavkin on 18/04/2019.
//  Copyright © 2019 AnatolyRyavkin. All rights reserved.
//

#import "Drawing.h"

@implementation Drawing

-(double)returnRandomCountColor{
    double result=((double)((arc4random()*10000)%1000))/1000;
    return result;
}
-(UIColor*)randomColor{
    return [UIColor colorWithRed:[self returnRandomCountColor] green:[self returnRandomCountColor] blue:[self returnRandomCountColor] alpha:1];
}
#pragma mark - DrawAtParametrs

-(void)drawStarCountTop: (int) countAngle andSizeRelationTops: (CGFloat) sizeRelationTops andBeginAngle: (CGFloat) angle andRadius: (int) radius andPointCoorCenter: (CGPoint) pointCenter{

    CGContextRef context=UIGraphicsGetCurrentContext();
    //CGFloat countAngle=5; // count tops star
    //CGFloat sizeRelationTops=0.5; // relationship tops out to in
    //CGFloat angle=M_PI; // begin angle first top
    //CGFloat radius=100; // radius circle insading this star
    //CGPoint pointCenter=CGPointMake(CGRectGetMidX(self.bounds),CGRectGetMidY(self.bounds)); //

//arrayTops

    NSMutableArray*arrayTops=[[NSMutableArray alloc]init];
    CGFloat angleTemp=angle;
    NSLog(@"tempAngleSm=%f",angleTemp);
    for(int i=0;i<countAngle;i++){
        CGPoint pointTop=CGPointMake(pointCenter.x+radius*sin(angleTemp), pointCenter.y+radius*cos(angleTemp));
        [arrayTops addObject:[NSValue valueWithCGPoint: pointTop]];
        angleTemp=angleTemp+2*M_PI/countAngle;
    }

//arrayIntSmolTops

    angleTemp=angle+M_PI/countAngle;
    NSLog(@"tempAngleSm=%f",angleTemp);
    CGFloat radiusSm=sizeRelationTops*radius;
    NSMutableArray*arrayIntSmTops=[[NSMutableArray alloc]init];
    for(int i=0;i<countAngle;i++){
        CGPoint pointTopInt=CGPointMake(pointCenter.x+radiusSm*sin(angleTemp), pointCenter.y+radiusSm*cos(angleTemp));
        [arrayIntSmTops addObject:[NSValue valueWithCGPoint: pointTopInt]];
        angleTemp=angleTemp+M_PI*2/countAngle;
    }

        // рисуем закрас звезды

    CGPoint pointTempBegin=[[arrayTops objectAtIndex:0] CGPointValue];
    CGPoint pointTemp;

    CGContextMoveToPoint(context, pointTempBegin.x,pointTempBegin.y);

    for(int i=0;i<countAngle;i++){
        pointTemp=[[arrayIntSmTops objectAtIndex:i] CGPointValue];
        CGContextAddLineToPoint(context, pointTemp.x, pointTemp.y);

        int j = (i<countAngle-1) ? i+1 : 0;
        pointTemp=[[arrayTops objectAtIndex:j] CGPointValue];
        CGContextAddLineToPoint(context, pointTemp.x, pointTemp.y);
    }
    CGContextSetFillColorWithColor (context, [self randomColor].CGColor);
    CGContextSetAlpha(context, 1);
    CGContextFillPath(context);

        //рисуем контур

    CGContextMoveToPoint(context, pointTempBegin.x,pointTempBegin.y);
    for(int i=0;i<countAngle;i++){
        pointTemp=[[arrayIntSmTops objectAtIndex:i] CGPointValue];
        CGContextAddLineToPoint(context, pointTemp.x, pointTemp.y);

        int j = (i<countAngle-1) ? i+1 : 0;
        pointTemp=[[arrayTops objectAtIndex:j] CGPointValue];
        CGContextAddLineToPoint(context, pointTemp.x, pointTemp.y);
    }
    CGContextSetStrokeColorWithColor (context, [self randomColor].CGColor);
    CGContextStrokePath(context);

        //рисуем внутренние линии

    pointTempBegin=[[arrayTops objectAtIndex:0] CGPointValue];
    CGContextMoveToPoint(context, pointTempBegin.x,pointTempBegin.y);
    CGContextSetStrokeColorWithColor (context, [self randomColor].CGColor);
    for(int i=0;i<countAngle;i++){
        pointTemp=[[arrayTops objectAtIndex:i] CGPointValue];
        CGContextMoveToPoint(context, pointCenter.x,pointCenter.y);
        CGContextAddLineToPoint(context, pointTemp.x, pointTemp.y);
        CGContextSetLineWidth(context,3);
        CGContextSetLineCap(context,  kCGLineCapButt);
        CGContextSetLineJoin(context, kCGLineJoinRound);
        CGContextStrokePath(context);
    }

    pointTempBegin=[[arrayIntSmTops objectAtIndex:0] CGPointValue];
    CGContextMoveToPoint(context, pointTempBegin.x,pointTempBegin.y);
    CGContextSetStrokeColorWithColor (context, [self randomColor].CGColor);
    for(int i=0;i<countAngle;i++){
        pointTemp=[[arrayIntSmTops objectAtIndex:i] CGPointValue];
        CGContextMoveToPoint(context, pointCenter.x,pointCenter.y);
        CGContextAddLineToPoint(context, pointTemp.x, pointTemp.y);
        CGContextSetLineWidth(context, 2);
        CGContextSetLineCap(context,  kCGLineCapRound);
        CGContextSetLineJoin(context, kCGLineJoinRound);
        CGContextStrokePath(context);
    }
}

#pragma mark-DrawRandom

-(void)drawRandomStar{

    CGContextRef context=UIGraphicsGetCurrentContext();
    CGFloat countAngle=arc4random()%15+5; // count tops star
    CGFloat sizeRelationTops=((CGFloat)(arc4random()%8))/10+0.2;   // relationship tops out to in
    CGFloat angle=M_PI; // begin angle first top
    int radius=arc4random()%100+25; // radius circle insading this star
    CGFloat pointCenterX= radius + arc4random()%(int)(CGRectGetMaxX(self.bounds)-2*radius);
    CGFloat pointCenterY= radius + arc4random()%(int)(CGRectGetMaxY(self.bounds)-2*radius);
    CGPoint pointCenter=CGPointMake(pointCenterX,pointCenterY); // pointcenter

//arrayTops

    NSMutableArray*arrayTops=[[NSMutableArray alloc]init];
    CGFloat angleTemp=angle;
    NSLog(@"tempAngleSm=%f",angleTemp);
    for(int i=0;i<countAngle;i++){
        CGPoint pointTop=CGPointMake(pointCenter.x+radius*sin(angleTemp), pointCenter.y+radius*cos(angleTemp));
        [arrayTops addObject:[NSValue valueWithCGPoint: pointTop]];
        angleTemp=angleTemp+2*M_PI/countAngle;
    }

//arrayIntSmolTops

    angleTemp=angle+M_PI/countAngle;
    NSLog(@"tempAngleSm=%f",angleTemp);
    CGFloat radiusSm=sizeRelationTops*radius;
    NSMutableArray*arrayIntSmTops=[[NSMutableArray alloc]init];
    for(int i=0;i<countAngle;i++){
        CGPoint pointTopInt=CGPointMake(pointCenter.x+radiusSm*sin(angleTemp), pointCenter.y+radiusSm*cos(angleTemp));
        [arrayIntSmTops addObject:[NSValue valueWithCGPoint: pointTopInt]];
        angleTemp=angleTemp+M_PI*2/countAngle;
    }

        // рисуем закрас звезды

    CGPoint pointTempBegin=[[arrayTops objectAtIndex:0] CGPointValue];
    CGPoint pointTemp;

    CGContextMoveToPoint(context, pointTempBegin.x,pointTempBegin.y);

    for(int i=0;i<countAngle;i++){
        pointTemp=[[arrayIntSmTops objectAtIndex:i] CGPointValue];
        CGContextAddLineToPoint(context, pointTemp.x, pointTemp.y);

        int j = (i<countAngle-1) ? i+1 : 0;
        pointTemp=[[arrayTops objectAtIndex:j] CGPointValue];
        CGContextAddLineToPoint(context, pointTemp.x, pointTemp.y);
    }
    CGContextSetFillColorWithColor (context, [self randomColor].CGColor);
    CGContextSetAlpha(context, 1);
    CGContextFillPath(context);

        //рисуем контур

    CGContextMoveToPoint(context, pointTempBegin.x,pointTempBegin.y);
    for(int i=0;i<countAngle;i++){
        pointTemp=[[arrayIntSmTops objectAtIndex:i] CGPointValue];
        CGContextAddLineToPoint(context, pointTemp.x, pointTemp.y);

        int j = (i<countAngle-1) ? i+1 : 0;
        pointTemp=[[arrayTops objectAtIndex:j] CGPointValue];
        CGContextAddLineToPoint(context, pointTemp.x, pointTemp.y);
    }
    CGContextSetStrokeColorWithColor (context, [self randomColor].CGColor);
    CGContextStrokePath(context);

        //рисуем внутренние линии

    pointTempBegin=[[arrayTops objectAtIndex:0] CGPointValue];
    CGContextMoveToPoint(context, pointTempBegin.x,pointTempBegin.y);
    CGContextSetStrokeColorWithColor (context, [self randomColor].CGColor);
    for(int i=0;i<countAngle;i++){
        pointTemp=[[arrayTops objectAtIndex:i] CGPointValue];
        CGContextMoveToPoint(context, pointCenter.x,pointCenter.y);
        CGContextAddLineToPoint(context, pointTemp.x, pointTemp.y);
        CGContextSetLineWidth(context,3);
        CGContextSetLineCap(context,  kCGLineCapButt);
        CGContextSetLineJoin(context, kCGLineJoinRound);
        CGContextStrokePath(context);
    }

    pointTempBegin=[[arrayIntSmTops objectAtIndex:0] CGPointValue];
    CGContextMoveToPoint(context, pointTempBegin.x,pointTempBegin.y);
    CGContextSetStrokeColorWithColor (context, [self randomColor].CGColor);
    for(int i=0;i<countAngle;i++){
        pointTemp=[[arrayIntSmTops objectAtIndex:i] CGPointValue];
        CGContextMoveToPoint(context, pointCenter.x,pointCenter.y);
        CGContextAddLineToPoint(context, pointTemp.x, pointTemp.y);
        CGContextSetLineWidth(context, 2);
        CGContextSetLineCap(context,  kCGLineCapRound);
        CGContextSetLineJoin(context, kCGLineJoinRound);
        CGContextStrokePath(context);
    }
}

#pragma mark -draw

- (void)drawRect:(CGRect)rect {

    //rect=CGRectMake(300, 400, 100, 100);
    //CGContextRef context=UIGraphicsGetCurrentContext();
    //CGContextSetFillColorWithColor(context, [UIColor greenColor].CGColor);
    //CGContextAddRect(context, rect);
    //CGContextFillPath(context);
    
    CGFloat countAngle=arc4random()%15+5; // count tops star
    CGFloat sizeRelationTops=((CGFloat)(arc4random()%8))/10+0.2;   // relationship tops out to in

    // ниже выбираем из двух вариантов - 1 звезда с параметрами или много рандомных

    [self drawStarCountTop:countAngle andSizeRelationTops:sizeRelationTops andBeginAngle:M_PI andRadius:150 andPointCoorCenter:CGPointMake(CGRectGetMidX(self.bounds),CGRectGetMidY(self.bounds))];

    //int i=arc4random()%5+2;
    //      for(int j=0 ;j<i; j++)
    // [self drawRandomStar];
}

/*
 блок - закрашиваем арками !!!!
 CGPoint pointTempBegin;
 CGPoint pointTempEnd;
 for(int i=0;i<5;i++){
 pointTempBegin=[[arrayTops objectAtIndex:i] CGPointValue];
 pointTempEnd=[[arrayIntSmTops objectAtIndex:i] CGPointValue];

 CGContextMoveToPoint(context, pointTempBegin.x,pointTempBegin.y);
 CGContextAddLineToPoint(context, pointTempEnd.x, pointTempEnd.y);


 //CGContextSetStrokeColorWithColor (context, [self randomColor].CGColor);
 //CGContextStrokePath(context);

 //CGContextSetFillColorWithColor(context, [self randomColor].CGColor);
 //CGContextFillPath(context);

 CGContextAddArc(context, 300, 300, radiusSm, 0, 2*M_PI, YES);

 pointTempBegin=pointTempEnd;
 int j = (i<4) ? i+1 : 0;
 pointTempEnd=[[arrayTops objectAtIndex:j] CGPointValue];

 CGContextMoveToPoint(context, pointTempBegin.x,pointTempBegin.y);
 CGContextAddLineToPoint(context, pointTempEnd.x, pointTempEnd.y);

 //CGContextSetStrokeColorWithColor (context, [self randomColor].CGColor);
 //CGContextStrokePath(context);

 //CGContextSetFillColorWithColor(context, [self randomColor].CGColor);
 //CGContextFillPath(context);



 CGContextAddArc(context, 300, 300, radiusSm, 0, 2*M_PI, NO);


 //CGContextSetStrokeColorWithColor (context, [self randomColor].CGColor);
 //CGContextSetFillColorWithColor(context, [self randomColor].CGColor);

 a=a+M_PI*2/5;

 //CGContextStrokePath(context);
 }
 //CGContextSetStrokeColorWithColor (context, [self randomColor].CGColor);
 //CGContextStrokePath(context);
 CGContextFillPath(context);
 */

@end
