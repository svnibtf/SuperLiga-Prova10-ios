//
//  PickerViewPopUp.m
//  Car4Sale
//
//  Created by Karolina França on 10/09/16.
//  Copyright © 2016 Estudio Criar. All rights reserved.
//

#import "PickerViewPopUp.h"
@interface PickerViewPopUp(){
    int index;
}
@end
@implementation PickerViewPopUp

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        [[NSBundle mainBundle] loadNibNamed:@"PickerViewPopUp" owner:self options:nil];
        self.bounds = self.view.bounds;
        _view.bounds = self.bounds;
        [self addSubview:self.view];
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [[NSBundle mainBundle] loadNibNamed:@"PickerViewPopUp" owner:self options:nil];
        self.bounds = self.view.bounds;
        _view.bounds = self.bounds;
        [self addSubview:self.view];
    }
    return self;
}
-(void)InitWithOptions: (NSArray *) array AndSelectedIndex:(int) i{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    _options = [[NSMutableArray alloc] init];
    [_options addObjectsFromArray:array];
    [_PickerView reloadAllComponents];
    [_PickerView selectRow:i inComponent:0 animated:NO];
    
    index = i;
}
- (IBAction)Done:(id)sender {
    [_delegate PickerViewSelectedIndex:index];
    [self removeFromSuperview];
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component{
    return [_options count];
}
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _options[row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    index = (int)row;
    
}
@end
