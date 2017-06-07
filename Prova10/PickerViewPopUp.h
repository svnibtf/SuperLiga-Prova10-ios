//
//  PickerViewPopUp.h
//  Car4Sale
//
//  Created by Karolina França on 10/09/16.
//  Copyright © 2016 Estudio Criar. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PickerViewPopUpDelegate <NSObject>

@required
-(void)PickerViewSelectedIndex:(int) index;

@end
@interface PickerViewPopUp : UIView
@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UIPickerView *PickerView;
@property (nonatomic) NSMutableArray *options;
@property (weak, nonatomic) id <PickerViewPopUpDelegate> delegate;
- (IBAction)Done:(id)sender;
-(void)InitWithOptions: (NSArray *) array AndSelectedIndex:(int) i;
@end
