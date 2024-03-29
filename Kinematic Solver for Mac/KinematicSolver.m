//
//  KinematicSolver.m
//  Kinematic Solver for Mac
//
//  Created by Kian Gorgichuk on 14-10-19.
//  Copyright (c) 2017 Kian Gorgichuk. All rights reserved.
//

#import "KinematicSolver.h"

@implementation KinematicSolver

//Initialization
-(id) init {
    //Set Blank Value to Non-Valid Number
    _blankValue = -1;
    
    if(!(self = [ super init ]) )
        return nil;
    
    return self;

}

//Setters

//Method returns NO if error occures.
-(bool) setTime: (NSNumber*) time andError: (NSError**) error{
    if( [time doubleValue] <= 0) {
       *error = [ KinematicSolver createError: @"Time Cannot be Set Less Than or Equal to Zero!"
                         Domain: @"com.Gorgichuk.KinematicSolver.UserDomain"
                         Code: 1 ];
    } else {
        _T = [ time doubleValue];
        return YES;
        
    }
    
    return NO;
}

-(void) setDisplacement: (NSNumber*) displacement {
    _D = [ displacement doubleValue];
}

-(void) setAcceleration: (NSNumber*) accel {
    _A = [ accel doubleValue];

}

-(void) setInitialVelocity: (NSNumber*) initVelocity {
    _Vi = [ initVelocity doubleValue];
}

-(void) setFinalVelocity: (NSNumber*) finVelocity {
    _Vf = [ finVelocity doubleValue];
}

//Method returns NO if error occures.
-(bool) setBlankValue:(NSString*)value andError: (NSError**) error {
    _blankValueStr = [ [NSString alloc ] initWithString:value ];
    if([_blankValueStr isEqualToString:@"Displacement"]){
        _blankValue = 0;
    } else if([_blankValueStr isEqualToString:@"Time"]){
        _blankValue = 1;
    }else if([_blankValueStr isEqualToString:@"Acceleration"]){
        _blankValue = 2;
    } else if([_blankValueStr isEqualToString:@"InitialVelocity"]){
        _blankValue = 3;
    }else if([_blankValueStr isEqualToString:@"FinalVelocity"]){
        _blankValue = 4;
    }else{
        *error = [ KinematicSolver createError: @"setBlankValue parameter is not valid!"
                                        Domain: @"com.Gorgichuk.KinematicSolver.UserDomain"
                                          Code: 2 ];
        return NO;
    }
    
    return YES;
}

-(void) setBlankValueTesting: (int) value{
    _blankValue = value;
}

//Getters
-(NSNumber*) getTime {
    NSNumber *t = [ [ NSNumber alloc ] initWithDouble:_T ];
    return t;
}
-(NSNumber*) getDisplacement {
    NSNumber *d = [ [ NSNumber alloc ] initWithDouble:_D ];
    return d;
}
-(NSNumber*) getAcceleration {
    NSNumber *a = [ [ NSNumber alloc ] initWithDouble:_A ];
    return a;
}
-(NSNumber*) getInitialVelocity {
    NSNumber *vi = [ [ NSNumber alloc ] initWithDouble:_Vi ];
    return vi;
}
-(NSNumber*) getFinalVelocity {
    NSNumber *vf = [ [ NSNumber alloc ] initWithDouble:_Vf ];
    return vf;
}

-(NSString*) getBlankValue {
    return _blankValueStr;
}


/* Error Codes:
 * 1 = Time Set t<= 0
 * 2 = setBlankValueParameter Invalid
 * 3 = convertToDouble Error
 * 4 = DivideByZero Error
 * 5 = No BlankValue Selected
 * 6 = Invalid Physics Scenario
 * 7 = Two Possible Values - Square Root
 * 8 = Two Possible Values - Quadratic Equation
 */
+(NSError*) createError: (NSString*) msg Domain: (NSString*) dom Code:(int) c {
    // Create the error.
    NSString *domain = @"com.Gorgichuk.KinematicSolver.ErrorDomain";

    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    [userInfo setObject:msg forKey:NSLocalizedDescriptionKey];
    
    // Populate the error reference.
    NSError *error = [[NSError alloc] initWithDomain:domain
                                        code:c
                                    userInfo:userInfo];
    return error;
}



//Convert To Double
//Method returns nil if error occures.
+(NSNumber*) convertToDouble: (NSString*) str andError: (NSError**) error{
    NSNumberFormatter *f = [ [ NSNumberFormatter alloc ] init ];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber *num = [ f numberFromString: str ];
    
    if(num == nil)
    {
        *error = [ KinematicSolver createError: @"A Value(s) Entered is Not a Valid Number!"
                                        Domain: @"com.Gorgichuk.KinematicSolver.UserDomain"
                                          Code: 3 ];
        return nil;
    }
    return num;
}

@end
