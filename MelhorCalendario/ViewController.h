//
//  ViewController.h
//  MelhorCalendario
//
//  Created by Felipe Marques Ramos on 29/03/15.
//  Copyright (c) 2015 Felipe Marques Ramos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIGestureRecognizerDelegate>


//Properties

#pragma Semana e seus Botoes
@property NSArray *weekArray;
@property (weak, nonatomic) IBOutlet UIButton *domButton;
@property (weak, nonatomic) IBOutlet UIButton *segButton;
@property (weak, nonatomic) IBOutlet UIButton *tercButton;
@property (weak, nonatomic) IBOutlet UIButton *quartButton;
@property (weak, nonatomic) IBOutlet UIButton *quintButton;
@property (weak, nonatomic) IBOutlet UIButton *sexButton;
@property (weak, nonatomic) IBOutlet UIButton *sabButton;
@property (weak, nonatomic) IBOutlet UIView *weekView;

#pragma Belas Labels
@property (weak, nonatomic) IBOutlet UILabel *thisMonth;
@property (weak, nonatomic) IBOutlet UILabel *selectedDayLabel;

#pragma Datas e afins
@property NSDate *today;
@property NSDate *weekSunday;
@property NSDate *selectedDay;
@property NSCalendar *calendar;



//Actions
- (IBAction)voltar:(id)sender;
- (IBAction)proximo:(id)sender;



@end

