//
//  ViewController.h
//  MelhorHistorico
//
//  Created by Felipe Marques Ramos on 25/03/15.
//  Copyright (c) 2015 Felipe Marques Ramos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIGestureRecognizerDelegate>



//@property (weak, nonatomic) IBOutlet UIButton *voltarBotao;
//@property (weak, nonatomic) IBOutlet UIButton *proximoBotao;

@property (weak, nonatomic) IBOutlet UILabel *mes;
@property (weak, nonatomic) IBOutlet UILabel *mesAtual;

@property (weak, nonatomic) IBOutlet UIButton *domBotao;
@property (weak, nonatomic) IBOutlet UIButton *segBotao;
@property (weak, nonatomic) IBOutlet UIButton *tercBotao;
@property (weak, nonatomic) IBOutlet UIButton *quartBotao;
@property (weak, nonatomic) IBOutlet UIButton *quintBar;
@property (weak, nonatomic) IBOutlet UIButton *sexBar;
@property (weak, nonatomic) IBOutlet UIButton *sabBar;

@property NSArray *semana;
@property NSDate *today;
@property NSDate *thisWeek;

@property NSDateComponents *components;
@property NSCalendar *calendario;

- (IBAction)voltar:(id)sender;
- (IBAction)proximo:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *subView;
@end

