//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Xcode Nerd on 12/31/11.
//  Copyright (c) 2011 AmpedSoft, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void)pushOperand: (double)operand;
- (double)performOperation: (NSString *)operation;
- (void)performClear;

@end
