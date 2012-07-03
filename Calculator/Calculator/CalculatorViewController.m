//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Xcode Nerd on 12/26/11.
//  Copyright (c) 2011 AmpedSoft, LLC. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic) BOOL decimalHasBeenPressed;
@property (nonatomic, strong) CalculatorBrain *brain;
@end

@implementation CalculatorViewController
@synthesize display = _display;
@synthesize tape = _tape;
@synthesize userIsInTheMiddleOfEnteringANumber = _userIsInTheMiddleOfEnteringANumber;
@synthesize decimalHasBeenPressed = _decimalHasBeenPressed;
@synthesize brain = _brain;

//Lazy Instantiation of our Brain
-(CalculatorBrain *)brain
{
    if (!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = [sender currentTitle];
    if (self.userIsInTheMiddleOfEnteringANumber) {
    self.display.text = [self.display.text stringByAppendingString:digit]; 
    } else {
        self.tape.text = [self.tape.text stringByAppendingString:@" "];
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
    self.tape.text = [self.tape.text stringByAppendingString:digit];
}
- (IBAction)decimalPressed:(id)sender {
    if (!self.decimalHasBeenPressed)
    {
        NSString *decimal = [sender currentTitle];
        if (self.userIsInTheMiddleOfEnteringANumber) {
            self.display.text = [self.display.text stringByAppendingString:decimal]; 
            self.tape.text = [self.tape.text stringByAppendingString:decimal];   
            self.decimalHasBeenPressed = YES;
        } else {
            self.display.text = @"0."; // leading zero
            self.tape.text = [self.tape.text stringByAppendingString:@"0."];
            self.userIsInTheMiddleOfEnteringANumber = YES;
            self.decimalHasBeenPressed = YES;
        }
    }
}

- (IBAction)clearPressed:(id)sender {
    [self.brain performClear];
    self.display.text=@"0";
    self.tape.text=@"";
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.decimalHasBeenPressed = NO;
    
}

- (IBAction)enterPressed {
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.decimalHasBeenPressed = NO;
    // enter a space on the tape
    self.tape.text = [self.tape.text stringByAppendingString:@" "]; 
}

- (IBAction)operationPressed:(UIButton *)sender {
    
    if (self.userIsInTheMiddleOfEnteringANumber) [self enterPressed];
    NSString *operation = [sender currentTitle];
    
    self.tape.text = [self.tape.text stringByAppendingString:@" "];
    self.tape.text = [self.tape.text stringByAppendingString:operation];
    
    //TO-DO:
    // extra-credit: put an equal sign at the end of the tape and keep removing them
    // self.tape.text = [self.tape.text stringByAppendingString:@"="];
    
    double result = [self.brain performOperation:operation];
    self.display.text = [NSString stringWithFormat:@"%g", result];
    
    
}



- (void)viewDidUnload {
    [self setTape:nil];
    [super viewDidUnload];
}
@end
