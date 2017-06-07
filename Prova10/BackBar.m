//
//  BackBar.m
//  Heey
//
//  Created by Karolina França on 09/12/16.
//  Copyright © 2016 Estudio Criar. All rights reserved.
//

#import "BackBar.h"

@implementation BackBar

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [[NSBundle mainBundle] loadNibNamed:@"BackBar" owner:self options:nil];
        self.bounds = self.view.bounds;
        _view.bounds = self.bounds;
        [self addSubview:self.view];
        
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        [[NSBundle mainBundle] loadNibNamed:@"BackBar" owner:self options:nil];
        self.bounds = self.view.bounds;
        _view.bounds = self.bounds;
        [self addSubview:self.view];
        
    }
    return self;
}
@end
