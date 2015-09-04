//
//  LoginVC.m
//  NeighbourFriends
//
//  Created by gus on 15/8/30.
//  Copyright (c) 2015年 gujitao. All rights reserved.
//

#import "LoginVC.h"
#import "RegisterVC.h"


@interface LoginVC ()
{
    
}

@property(nonatomic,strong)IBOutlet UITextField*mobileTextField;
@property(nonatomic,strong)IBOutlet UITextField* passwordTextField;


@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)loginButtonClicked:(id)sender
{
    
    
}

-(IBAction)registerButtonClicked:(id)sender
{
    RegisterVC*regvc = [self.storyboard instantiateViewControllerWithIdentifier:@"RegisterVC"];
    regvc.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
    [self.navigationController pushViewController:regvc animated:YES];
    
}

@end
