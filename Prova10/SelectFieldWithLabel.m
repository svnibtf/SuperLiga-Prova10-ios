//
//  SelectFieldWithLabel.m
//  Car4Sale
//
//  Created by Karolina França on 19/09/16.
//  Copyright © 2016 Estudio Criar. All rights reserved.
//

#import "SelectFieldWithLabel.h"
@implementation SelectFieldWithLabel

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        [[NSBundle mainBundle] loadNibNamed:@"SelectFieldWithLabel" owner:self options:nil];
        self.bounds = self.view.bounds;
        _view.bounds = self.bounds;
        [self addSubview:self.view];
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [[NSBundle mainBundle] loadNibNamed:@"SelectFieldWithLabel" owner:self options:nil];
        self.bounds = self.view.bounds;
        _view.bounds = self.bounds;
        [self addSubview:self.view];
    }
    return self;
}
-(void)SetPadding:(float) padding{
    _PaddingLeft.constant = padding;
    _PaddingRight.constant = padding;
}
-(void)InitWithOptions: (NSArray *) array PLaceholder:(NSString *) placeholder AndLabel:(NSString *) label{
    _options = [[NSMutableArray alloc] init];
    [_options addObject:placeholder];
    [_options addObjectsFromArray:array];
    
    _Label.text = label;
    _Field.placeholder = placeholder;
    
    [self SelectAtIndex:0];
}
-(void)SelectAtIndex:(int) index{
    _selectedIndex = index;
    if(index == 0){
        _Field.text = @"";
    }else{
        _Field.text = [NSString stringWithFormat:@"%@", [_options objectAtIndex:index]];
    }
    
    
}
- (IBAction)SelectValue:(id)sender {
    PickerViewPopUp *picker = [[AppController instance] ShowPickerViewWithOptions:_options AndSelectIndex:_selectedIndex];
    picker.delegate = self;
}

-(void)PickerViewSelectedIndex:(int) index{
    [self SelectAtIndex:index];
    [_delegate SelectedIndex:index OfField:self];
}
@end
