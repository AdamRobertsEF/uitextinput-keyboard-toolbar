/*
 UITextView+toolbar.m
 
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

#import "UITextView+toolbar.h"

@implementation UITextView (toolbar)

-(void)addKeyboard:(BOOL)animated previous:(SEL)previousSelector nextSelector:(SEL)nextSelector doneSelector:(SEL)doneSelector{
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,1024,44)];
    [toolBar setBarStyle:UIBarStyleBlack];
    [toolBar setTranslucent:TRUE];
    UIBarButtonItem *previous = [[UIBarButtonItem alloc] initWithTitle:@"Previous" style:UIBarButtonItemStyleBordered target:self action:previousSelector];
    
    UIBarButtonItem *next = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleBordered target:self action:nextSelector];
    
    UIBarButtonItem *seperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:doneSelector];
    
    [toolBar setItems:@[previous,next,seperator,done] animated:animated];
    
    self.inputAccessoryView = toolBar;
}

@end
