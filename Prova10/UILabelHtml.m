//
//  UILabelHtml.m
//  Agenda Digital
//
//  Created by Karolina França on 14/06/16.
//  Copyright © 2016 Estudio Criar. All rights reserved.
//

#import "UILabelHtml.h"

@implementation UILabelHtml

- (void) setHtml: (NSString*) html
{
    UIFont *font = self.font;
    NSError *err = nil;

    NSMutableAttributedString *htmlData =
    [[NSMutableAttributedString alloc]
     initWithData: [html dataUsingEncoding:NSISOLatin1StringEncoding]
     options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
     documentAttributes: nil
     error: &err];
    
    
    self.attributedText = htmlData;
    [self setFont:font];
    if(err)
        NSLog(@"Unable to parse label text: %@", err);
}

@end
