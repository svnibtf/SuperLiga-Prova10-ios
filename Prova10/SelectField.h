//
//  SelectField.h
//  Car4Sale
//
//  Created by Karolina França on 05/09/16.
//  Copyright © 2016 Estudio Criar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppController.h"
#import "PickerViewPopUp.h"
@protocol SelectFieldDelegate <NSObject>

@required
-(void)SelectedIndex:(int) index OfField:(id) field;

@end
@interface SelectField : UIView<PickerViewPopUpDelegate>
@property (weak, nonatomic) id <SelectFieldDelegate> delegate;
@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UILabel *Label;
@property (weak, nonatomic) IBOutlet UIImageView *ArrowView;
@property (nonatomic) int selectedIndex;
@property (nonatomic) NSMutableArray *options;
-(void)InitWithOptions: (NSArray *) array AndPLaceholder:(NSString *) placeholder;
-(void)SelectAtIndex:(int) index;
- (IBAction)SelectValue:(id)sender;
@end
