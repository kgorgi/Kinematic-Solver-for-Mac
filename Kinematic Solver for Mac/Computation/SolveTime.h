//
//  SolveTime.h
//  Kinematic Solver for Mac
//
//  Created by Kian Gorgichuk on 2017-05-14.
//  Copyright © 2017 Kian Gorgichuk. All rights reserved.
//

#ifndef SolveTime_h
#define SolveTime_h

#import "KinematicSolver.h"

@interface SolveTime : KinematicSolver

-(id) init;
-(NSNumber*) calculateTime: (NSError**) error;

+(double) quadEquation: (NSError**) error A:(double) a andb: (double) b withc:(double) c;

@end

#endif /* SolveTime_h */
