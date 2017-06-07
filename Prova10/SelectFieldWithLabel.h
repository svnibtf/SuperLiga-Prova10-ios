//
//  SelectFieldWithLabel.h
//  Car4Sale
//
//  Created by Karolina França on 19/09/16.
//  Copyright © 2016 Estudio Criar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppController.h"
#import "PickerViewPopUp.h"
@protocol SelectFieldWithLabelDelegate <NSObject>

@required
-(void)SelectedIndex:(int) index OfField:(id) field;

@end
@interface SelectFieldWithLabel : UIView<PickerViewPopUpDelegate>
@property (weak, nonatomic) id <SelectFieldWithLabelDelegate> delegate;
@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UILabel *Label;
@property (weak, nonatomic) IBOutlet UITextField *Field;
@property (nonatomic) NSMutableArray *options;
@property (nonatomic) int selectedIndex;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *PaddingRight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *PaddingLeft;
-(void)InitWithOptions: (NSArray *) array PLaceholder:(NSString *) placeholder AndLabel:(NSString *) label;
-(void)SetPadding:(float) padding;
-(void)SelectAtIndex:(int) index;
- (IBAction)SelectValue:(id)sender;
@end
