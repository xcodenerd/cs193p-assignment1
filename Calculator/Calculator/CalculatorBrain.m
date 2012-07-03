//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Xcode Nerd on 12/31/11.
//  Copyright (c) 2011 AmpedSoft, LLC. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray * operandStack; 
@end

@implementation CalculatorBrain

@synthesize operandStack = _operandStack;

- (NSMutableArray *)operandStack
{
    // Lazy Initialization
    if (!_operandStack) {
        _operandStack = [[NSMutableArray alloc]init];
    }
    return _operandStack;
}

- (void)pushOperand:(double)operand
{
    NSNumber *operandObject = [NSNumber numberWithDouble:operand];
    [self.operandStack addObject:operandObject];
}

- (double)popOperand
{
    NSNumber *operandObject = [self.operandStack lastObject];
    if (operandObject) [self.operandStack removeLastObject];
    return [operandObject doubleValue];
}

- (double)performOperation:(NSString *)operation 
{
    double result = 0;
    
    if ([operation isEqualToString:@"+"]) {         // Addition
        result = [self popOperand] + [self popOperand];
    } else if ([@"*" isEqualToString:operation]) { // Multiplication
        result = [self popOperand] * [self popOperand];        
    } else if ([@"-" isEqualToString:operation]) {  // Subtraction order matters
        double subrahend = [self popOperand];       // 4 2 - => 4-2 not 2-4
        result = [self popOperand] - subrahend;
    } else if ([@"/" isEqualToString:operation]) {  // Division: 4 2 / => 2/4
        double divisor = [self popOperand];
        if (divisor) result = [self popOperand] / divisor;
    } else if ([@"sin" isEqualToString:operation]) { // sin()
        result = sin([self popOperand]);
    } else if ([@"tan" isEqualToString:operation]) { // tan()
        result = tan([self popOperand]);
    } else if ([@"cos" isEqualToString:operation]) { // cos()
        result = cos([self popOperand]);
    } else if ([@"sqrt" isEqualToString:operation]) { // sqrt()
        result = sqrt([self popOperand]);
    } else if ([@"π" isEqualToString:operation]) { // M_PI()
        [self pushOperand:M_PI];
        result = M_PI;
    }
    
    [self pushOperand:result]; 
    return result;    
}

- (void)performClear
{
    // clear operand stack
    _operandStack = [[NSMutableArray alloc] init];
}

@end
