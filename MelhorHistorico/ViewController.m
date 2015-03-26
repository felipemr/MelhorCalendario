//
//  ViewController.m
//  MelhorHistorico
//
//  Created by Felipe Marques Ramos on 25/03/15.
//  Copyright (c) 2015 Felipe Marques Ramos. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize domBotao,segBotao,tercBotao,quartBotao,quintBar,sabBar,sexBar,components,calendario,today,thisWeek;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //setando o formato desejado para a string do dia
    NSDateFormatter *format=[[NSDateFormatter alloc]init];
    [format setDateStyle:NSDateFormatterLongStyle];
    
    today=[[NSDate alloc]init];//setando o hoje
    NSLog(@"Hoje :%@",[format stringFromDate:today]);
    
    
    calendario=[NSCalendar currentCalendar];// pega o calendario default do sistema
    
    
    // pegando o primeiro dia da semana
    NSDateComponents *weekDayComp=[calendario components:(NSCalendarUnitWeekday) fromDate:today];
    NSLog(@"dia da semana %lu",[weekDayComp weekday]);
    NSDateComponents *daysToSubstract=[[NSDateComponents alloc]init];
    [daysToSubstract setDay:0-([weekDayComp weekday]-1)];
    thisWeek=[calendario dateByAddingComponents:daysToSubstract toDate:today options:0];
    NSLog(@"o primeiro dia da semana :%@",[format stringFromDate:thisWeek]);
    
    
    // init na array de botoes da semana
    _semana=@[domBotao,segBotao,tercBotao,quartBotao,quintBar,sexBar,sabBar];
    
    
    NSDateFormatter *soDia=[[NSDateFormatter alloc]init];
    soDia.dateFormat=@"dd";
    int dom=[[NSString stringWithFormat:@"%@",[soDia stringFromDate:thisWeek]] integerValue];
    NSLog(@"%i",dom);
    
    for (int i=0; i<_semana.count; i++) {
        [_semana[i] setTag:dom+i];
        [_semana[i] setTitle:[NSString stringWithFormat:@"%li",(long)[_semana[i] tag]] forState:UIControlStateNormal];
    }
    
    
    for (UIButton *botao in _semana) {
        [botao addTarget:self action:@selector(dia:) forControlEvents:UIControlEventTouchDown];
        
        if (botao.tag==[[NSString stringWithFormat:@"%@",[soDia stringFromDate:today]] integerValue]) {
            [botao setTitle:@"hoje" forState:UIControlStateNormal];
        }
    }
    
    [_mes setText:[NSString stringWithFormat:@"%@",[format stringForObjectValue:today]]];
    
    
    //swypeLeft proximo
    UISwipeGestureRecognizer *recognizerLeft;
    recognizerLeft.delegate=self;
    recognizerLeft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swypeLeft:)];
    [recognizerLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:recognizerLeft];
    
    
    //swypeRight volta
    UISwipeGestureRecognizer *recognizerRight;
    recognizerRight.delegate=self;
    recognizerRight=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swypeRight:)];
    [recognizerRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:recognizerRight];
    
    
    //mes atual
    NSDateFormatter *soMes=[[NSDateFormatter alloc]init];
    soMes.dateFormat=@"MMMM";
    [_mesAtual setText:[soMes stringFromDate:today]];
}

-(void)dia:(UIButton*)sender{
    
    NSDateFormatter *format=[[NSDateFormatter alloc]init];
    [format setDateStyle:NSDateFormatterLongStyle];
    
    NSDateComponents *diaSelecComp=[[NSDateComponents alloc]init];
    NSDateComponents *sundayComp=[calendario components:(NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear) fromDate:thisWeek];
    NSLog(@"domingoDia :%lu",[sundayComp day] );
    
    
    NSLog(@"TAG :%li",(long)sender.tag-[sundayComp day]);
    [diaSelecComp setDay:[sundayComp day]+(sender.tag-[sundayComp day])];
    [diaSelecComp setMonth:[sundayComp month]];
    [diaSelecComp setYear:[sundayComp year]];
    NSLog(@"%ld",(long)[diaSelecComp day]);
    NSDate *diaSelec=[calendario dateFromComponents:diaSelecComp];
    NSLog(@"o dia selecionado FOI: %@",diaSelec);
    
    [_mes setText:[NSString stringWithFormat:@"%@",[format stringFromDate:diaSelec]]];
    //    [components setDay:(components.day-sender.tag)+[components day]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)swypeRight:(id)sender{
    
//    [UIView animateWithDuration:.2 animations:^{
//        for (UIButton *botao in _semana) {
//            [botao setTransform:CGAffineTransformMakeTranslation(350, 0)];
//        }
//    } completion:^(BOOL finished) {
//        [self proximo:sender];
//    }];
    
    CATransition *animation =[CATransition animation];
    [animation setDelegate:self];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromLeft];
    [animation setDuration:.5];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [_subView.layer addAnimation:animation forKey:kCATransition];
    [self voltar:sender];
}

-(void)swypeLeft:(id)sender{
    
//    [UIView animateWithDuration:.2 animations:^{
//        for (UIButton *botao in _semana) {
//            [botao setTransform:CGAffineTransformMakeTranslation(-400, 0)];
//        }
//    } completion:^(BOOL finished) {
//        [self voltar:sender];
//    }];
    
    CATransition *animation =[CATransition animation];
    [animation setDelegate:self];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromRight];
    [animation setDuration:.5];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [_subView.layer addAnimation:animation forKey:kCATransition];
    [self proximo:sender];
    
}


- (IBAction)voltar:(id)sender {
    NSLog(@"SEMANA ANTERIOR");
    
    
    NSDateComponents *sundayComp=[calendario components:(NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear) fromDate:thisWeek];
    
    [sundayComp setDay:[sundayComp day]-7];
    thisWeek=[calendario dateFromComponents:sundayComp];
    
    
    NSDateFormatter *soDia=[[NSDateFormatter alloc]init];
    soDia.dateFormat=@"dd";
    int dom=[[NSString stringWithFormat:@"%@",[soDia stringFromDate:thisWeek]] integerValue];
    int mes=[sundayComp month];
    int ano=[sundayComp year];
    int mostrar;
    for (int i=0; i<_semana.count; i++) {
        [_semana[i] setTag:dom+i];
        mostrar=[_semana[i] tag];
        if (mes==1||mes==3||mes==5||mes==7||mes==8||mes==10||mes==12) {//verifica se o mes tem mais de 31
            if (mostrar>31) {
                mostrar-=31;
                //                [_semana[i] setTag:[_semana[i] tag]-31];
            }
        }
        if (mes==4 ||mes==6||mes==9||mes==11) {//verifica se o mes tem mais de 30
            
            if (mostrar>30) {
                mostrar-=30;
                //                [_semana[i] setTag:[_semana[i] tag]-30];
            }
        }
        if (mes==2) {//verifica se é fevereiro
            
            if (ano%4==0) {//verifica se é bissexto
                if (mostrar>29) {
                    mostrar-=29;
                }
            }
            else{
                if (mostrar>28) {
                    mostrar-=28;
                }
            }
        }
        [_semana[i] setTitle:[NSString stringWithFormat:@"%i",mostrar] forState:UIControlStateNormal];
    }
    
    NSDateFormatter *soMes=[[NSDateFormatter alloc]init];
    soMes.dateFormat=@"MMMM";
    [_mesAtual setText:[soMes stringFromDate:thisWeek]];
    
    for (UIButton *botao in _semana) {
        [botao setTransform:CGAffineTransformMakeTranslation(400, 0)];
    }
    [UIView animateWithDuration:.2 animations:^{
        for (UIButton *botao in _semana) {
            [botao setTransform:CGAffineTransformMakeTranslation(0, 0)];
        }
    }];
    
}

- (IBAction)proximo:(id)sender {
    NSLog(@"PROXIMA SEMANA");
    
    NSDateComponents *sundayComp=[calendario components:(NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear) fromDate:thisWeek];
    
    [sundayComp setDay:[sundayComp day]+7];
    thisWeek=[calendario dateFromComponents:sundayComp];
    
    
    NSDateFormatter *soDia=[[NSDateFormatter alloc]init];
    soDia.dateFormat=@"dd";
    int dom=[[NSString stringWithFormat:@"%@",[soDia stringFromDate:thisWeek]] integerValue];
    int mes=[sundayComp month];
    int ano=[sundayComp year];
    int mostrar;
    for (int i=0; i<_semana.count; i++) {
        [_semana[i] setTag:dom+i];
        mostrar=[_semana[i] tag];
        if (mes==1||mes==3||mes==5||mes==7||mes==8||mes==10||mes==12) {//verifica se o mes tem mais de 31
            if (mostrar>31) {
                mostrar-=31;
                //                [_semana[i] setTag:[_semana[i] tag]-31];
            }
        }
        if (mes==4 ||mes==6||mes==9||mes==11) {//verifica se o mes tem mais de 30
            
            if (mostrar>30) {
                mostrar-=30;
                //                [_semana[i] setTag:[_semana[i] tag]-30];
            }
        }
        if (mes==2) {//verifica se é fevereiro
            
            if (ano%4==0) {//verifica se é bissexto
                if (mostrar>29) {
                    mostrar-=29;
                }
            }
            else{
                if (mostrar>28) {
                    mostrar-=28;
                }
            }
        }
        [_semana[i] setTitle:[NSString stringWithFormat:@"%i",mostrar] forState:UIControlStateNormal];
    }
    
    NSDateFormatter *soMes=[[NSDateFormatter alloc]init];
    soMes.dateFormat=@"MMMM";
    [_mesAtual setText:[soMes stringFromDate:thisWeek]];
    
    for (UIButton *botao in _semana) {
        [botao setTransform:CGAffineTransformMakeTranslation(-400, 0)];
    }
    [UIView animateWithDuration:.2 animations:^{
        for (UIButton *botao in _semana) {
            [botao setTransform:CGAffineTransformMakeTranslation(0, 0)];
        }
    }];
    
}




@end
