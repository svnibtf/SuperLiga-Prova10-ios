//
//  NavigationBar.m
//  Heey
//
//  Created by Karolina França on 03/11/16.
//  Copyright © 2016 Estudio Criar. All rights reserved.
//

#import "NavigationBar.h"
#import "AppController.h"

@implementation NavigationBar

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [[NSBundle mainBundle] loadNibNamed:@"NavigationBar" owner:self options:nil];
        self.bounds = self.view.bounds;
        _view.bounds = self.bounds;
        [self addSubview:self.view];
        
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        [[NSBundle mainBundle] loadNibNamed:@"NavigationBar" owner:self options:nil];
        self.bounds = self.view.bounds;
        _view.bounds = self.bounds;
        [self addSubview:self.view];
        
    }
    return self;
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGSize newSize = CGSizeMake(self.frame.size.width,55);
    return newSize;
}

- (IBAction)GoBack:(id)sender {
    [[AppController instance].CurrentView.navigationController popViewControllerAnimated:YES];
}
@end
