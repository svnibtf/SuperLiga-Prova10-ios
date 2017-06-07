//
//  PDFViewer.h
//  Agenda Digital
//
//  Created by Karolina França on 22/06/16.
//  Copyright © 2016 Estudio Criar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDFViewer : UIViewController<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic) NSURL *target;
@end
