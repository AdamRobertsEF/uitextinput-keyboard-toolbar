/*
 UITextInput+toolbar.m
 
 Created by Adam Roberts on 19/05/2012.
 Copyright (c) 2012 Enigmatic Flare Ltd. All rights reserved.
 http://www.enigmaticflare.com
 twitter:@enigmaticflare facebook/AdamRobertsEF
 
 Permission is hereby granted, free of charge, to any person
 obtaining a copy of this software and associated documentation
 files (the "Software"), to deal in the Software without
 restriction, including without limitation the rights to use,
 copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the
 Software is furnished to do so, subject to the following
 conditions:
 
 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 OTHER DEALINGS IN THE SOFTWARE.
 */ 

#import "UITextInput+toolbar.h"

@implementation UIView (toolbar)

-(void)setInputAccessoryView:(UIView *)inputAccessoryView{
    //Ignore this we handle this in addKeyboard
}

-(BOOL)respondsToSelector:(SEL)aSelector{
    if (aSelector == @selector(setInputAccessoryView:)){
        if ([self isKindOfClass:UISearchBar.class] || [self conformsToProtocol:@protocol(UITextInput)]){
            return TRUE;
        }
        else{
            return FALSE;
        }
    }
   return [super respondsToSelector:aSelector];
}



-(UIToolbar*)addToolbar:(BOOL)animated target:(id)target previous:(SEL)previousSelector nextSelector:(SEL)nextSelector doneSelector:(SEL)doneSelector{
    
    if (![self isKindOfClass:UISearchBar.class]){
        if (![self conformsToProtocol:@protocol(UITextInput)]) {
            NSAssert(@"addKeyboard failed", @"Class doesn't conform to UITextInput protocol");
            return nil;
        }
    }

    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,320,44)];
    [toolBar setBarStyle:UIBarStyleBlack];
    [toolBar setTranslucent:TRUE];
    
    UIBarButtonItem *previous = nil;
    UIBarButtonItem *next = nil;
    UIBarButtonItem *done = nil;
    NSMutableArray *items = [[NSMutableArray alloc]init];
    
    if (previousSelector) {
        previous = [[UIBarButtonItem alloc] initWithTitle:@"Previous"
                                                                     style:UIBarButtonItemStyleBordered
                                                                    target:target
                                                                    action:previousSelector];
        
        [items addObject:previous];
    }

    if (nextSelector) {
        next = [[UIBarButtonItem alloc] initWithTitle:@"Next"
                                                style:UIBarButtonItemStyleBordered
                                               target:target
                                               action:nextSelector];
        [items addObject:next];
    }
    
    UIBarButtonItem *seperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                               target:nil
                                                                               action:nil];
    
    [items addObject:seperator];
    
    
    if(doneSelector){
        done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                             target:target
                                                             action:doneSelector];
        
        [items addObject:done];
    }
    
    
    [toolBar setItems:items
             animated:animated];
    
    toolBar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    if ([self isKindOfClass:UISearchBar.class]){
        for(UIView *subView in self.subviews){
            if([subView isKindOfClass:UITextField.class]){
                [(UITextField *)subView setInputAccessoryView:toolBar];
            }
        }
    }
    
    if ([self isKindOfClass:UITextField.class]){
        [(UITextField *)self setInputAccessoryView:toolBar];
    }else{
        [(UITextView *)self setInputAccessoryView:toolBar];
    }
    return toolBar;
}



@end


